Return-Path: <cyrus@holtmann.org>
Message-ID: <5024DDE5.2030307@linux.intel.com>
Date: Fri, 10 Aug 2012 12:09:41 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v17 01/15] doc: Add telephony interface documents
References: <1343995640-19784-1-git-send-email-frederic.danis@linux.intel.com> <1343995640-19784-2-git-send-email-frederic.danis@linux.intel.com> <1344141450.2083.30.camel@aeonflux> <CABBYNZ+95Zx32T_Soz8Nms3reNcGpa3FsiyZpxS5zNzdsXhVvA@mail.gmail.com> <50238B05.4030203@linux.intel.com> <CABBYNZ+gQEC8iUMwUXO25TSXYFsktAjS083hXXH09Ec3DnDFzA@mail.gmail.com>
In-Reply-To: <CABBYNZ+gQEC8iUMwUXO25TSXYFsktAjS083hXXH09Ec3DnDFzA@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------030001090303030400070104"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------030001090303030400070104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello Luiz,

On 09/08/2012 16:42, Luiz Augusto von Dentz wrote:
> Hi Frederic,
>
> On Thu, Aug 9, 2012 at 1:03 PM, Frederic Danis
> <frederic.danis@linux.intel.com> wrote:
>>> They are mostly independent, oFono will never really acquire or
>>> anything like that, but there are some AT commands (+VGS,+VGM) that
>>> does notify PA about volume gain changes and as I said above it could
>>> be useful to notify about wideband speech in the same way.
>>>
>>
>> It is also possible that telephony agent implements a TelephonyClient
>> interface for each connection, object which should be returned by
>> NewConnection method.
>
> You should return the properties as well to avoid another round trip
> to get the properties of the client. Btw this requires yet another
> object and interface that increases the complexity of the solution.

OK, I add the client properties to return of NewConnection.

I agree with you this increase complexity, but as media transport is 
linked to the codec it uses I do not find another solution.

>> In this case BlueZ will listen to properties changes on this interface (like
>> for remote volume change) or call SetProperty (when receiving volume change
>> from PulseAudio).
>>
>> As MediaTransport may change during wideband speech HFP session, due to
>> codec re-negotiation, this architecture may simplify media transport code.
>
> I don't think we need to do the codec negotiation on acquire, it
> actually doesn't work since the transport cannot be reconfigured with
> another codec as by design the endpoints can only have 1 codec, so I
> suggest having the list of available codecs be given upfront in
> NewConnection then you actually negotiate the codec before responding.

Yes , I pass them in NewConnection method.

> If the remote device attempts to change the codec oFono then can check
> if the codec is available in the list of available codecs given on
> NewConnection, if it find a match then it accepts and emit a signal of
> codec changes that triggers a new transport to be configured.

In HFP 1.6 specs (chapter 4.11.3, page 32) I saw that after codec 
negotiation "the AG shall open the synchronous connection". This may 
imply that we will need to do it when PA tries to use HFP audio connection.

> Btw, Im not sure if this is really productive to discuss before we
> even have this working with 1.5, IMO is easier to do things step by
> step and the first step should be to get HFP 1.5 working as the
> current upstream does then we think about 1.6 and other profiles such
> as DUN and SAP.

I agree with you that most important point is to get a working HFP 1.5, 
but moving to HFP 1.6 may break the telephony interface if we do not 
take a look at it now.

Find attached new version of documents proposal.

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation


--------------030001090303030400070104
Content-Type: text/plain; charset=UTF-8;
 name="audio-telephony-design-new.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="audio-telephony-design-new.txt"

Telephony Interface Design
**************************

Introduction
============

The aim of this document is to briefly describe the telephony interface which
will allow external application to implement telephony related profiles
(headset, handsfree, dial-up networking and sim access).


The goal
========

Previous version of headset code in BlueZ needs the implementation of an AT
parser for each modem target or external telephony application (Maemo, oFono)
which is not the aim of Bluez.

The telephony interface allows BlueZ to focus on Bluetooth communication part
(connection, disconnection, authentication, authorization) and let external
application (i.e. oFono) take charge of the Telephony tasks (AT parsing and
modem specific code).
This will allow code to be simpler, easier to maintain and debug in both BlueZ
and telephony application.


Design
======

External applications, which should implement AT parsing and telephony part
will have to register an org.bluez.TelephonyAgent using this new interface.
This will setup a SDP record for the profile and a RFCOMM server listening for
incoming connection.

When a new device is connected, NewConnection method of TelephonyAgent is
called. The telephony agent must reply with a TelephonyClient object after
proper communication establishment (after SLC setup completes for HFP, or
directly for other profiles).

For Headset and Handsfree profiles, the interaction with the audio component
(i.e. PulseAudio) will be done by listening to TelephonyClient properties
changes.


Flow charts
===========

Here is some flowcharts of interactions between BlueZ, telephony agent (oFono)
and audio component (PulseAudio):

        .....>  Bluetooth communication between headset and phone
        ----->  Dbus messages and signals

Outgoing SCO connection - HFP <= 1.5
------------------------------------

When PulseAudio needs to setup the audio connection it will call media
transport acquire method. This will perform a SCO connection and return the SCO
socket file descriptor to PulseAUdio.

	PulseAudio              BlueZ           HF/AG
	|                         |               |
	|    transport acquire    |               |
	|------------------------>|               |
	|                         |  connect SCO  |
	|                         |..............>|
	|      return SCO fd      |               |
	|<------------------------|               |
	|                         |               |

Incoming SCO connection - HFP <= 1.5
------------------------------------

On an incoming SCO connection the profile will change to playing state.
On reception of this state change, PulseAudio will call media transport acquire
method to retrieve the SCO socket file descriptor.

	PulseAudio              BlueZ           HF/AG
	|                         |               |
	|                         |  connect SCO  |
	|                         |<..............|
	|  state changed signal   |               |
	|<------------------------|               |
	|                         |               |
	|    transport acquire    |               |
	|------------------------>|               |
	|                         |               |
	|      return SCO fd      |               |
	|<------------------------|               |
	|                         |               |

Codec negotiation - HFP AG - HFP v1.6
-------------------------------------------

On reception of HF available codecs command (AT+BAC), the gateway may start a
codec selection procedure which will end up by codec property update and setup
of the correct media transport.
When a media transport already exists and it uses a different codec, it should
be closed before correct one is setup. 

	PulseAudio          BlueZ            oFono           HF
	|                     |                |              |
	|                     |                | AT+BAC=u1,u2 |
	|                     |                |<.............|
	|                     |                |              |
	|                     |                |      OK      |
	|                     |                |.............>|
	|                     |                |              |
	|                     |                |   +BCS:id    |
	|                     |                |.............>|
	|                     |                |              |
	|                     |                |  AT+BCS=id   |
	|                     |                |<.............|
	|                     |                |              |
	|                     |                |      OK      |
	|                     |                |.............>|
	|                     | codec property |              |
	|                     | changed signal |              |
	|                     |<---------------|              |
	| configure Transport |                |              |
	|<--------------------|                |              |
	|                     |                |              |

It may also ne possible to force a codec selection procedure by calling "get
audio codec" procedure of TelephonyClient.

	PulseAudio          BlueZ             oFono          HF
	|                     |                 |             |
	|                     |    get codec    |             |
	|                     |---------------->|             |
	|                     |                 |   +BCS:id   |
	|                     |                 |............>|
	|                     |                 |             |
	|                     |                 |  AT+BCS=id  |
	|                     |                 |<............|
	|                     |                 |             |
	|                     |                 |      OK     |
	|                     |                 |............>|
	|                     | codec property  |             |
	|                     | changed signal  |             |
	|                     |<----------------|             |
	| configure Transport |                 |             |
	|<--------------------|                 |             |
	|                     |                 |             |

Outgoing SCO connection - HFP AG - HFP v1.6
-------------------------------------------

Idem than for HFP v1.5

Incoming SCO connection - HFP AG - HFP v1.6
-------------------------------------------

It is pretty the same here as for outgoing SCO connection, except that it is
started upon reception of AT+BCC from the headset.

	PulseAudio           BlueZ              oFono         HF
	|                      |                  |            |
	|                      |                  |   AT+BCC   |
	|                      |                  |<...........|
	|                      |                  |            |
	|                      |                  |     OK     |
	|                      |                  |...........>|
	|                      |    connection    |            |
	|                      | requested signal |            |
	|                      |<-----------------|            |
	|                      |                  |            |
	|                      |          connect SCO          |
	|                      |..............................>|
	| state changed signal |                  |            |
	|<---------------------|                  |            |
	|                      |                  |            |
	|  transport acquire   |                  |            |
	|--------------------->|                  |            |
	|                      |                  |            |
	|    return SCO fd     |                  |            |
	|<---------------------|                  |            |


Codec negotiation - HFP HF - HFP v1.6
-------------------------------------------

Codec selection procedure started by gateway will end up by codec property
update and setup of the correct media transport.
When a media transport already exists and it uses a different codec, it should
be closed before correct one is setup. 

	PulseAudio          BlueZ            oFono           HF
	|                     |                |              |
	|                     |                |   +BCS:id    |
	|                     |                |<.............|
	|                     |                |              |
	|                     |                |  AT+BCS=id   |
	|                     |                |.............>|
	|                     |                |              |
	|                     |                |      OK      |
	|                     |                |<.............|
	|                     | codec property |              |
	|                     | changed signal |              |
	|                     |<---------------|              |
	| configure Transport |                |              |
	|<--------------------|                |              |
	|                     |                |              |

Outgoing SCO connection - HFP HF - HFP v1.6
-------------------------------------------

On media transport acquire, the TelephonyClient is called to request connection
from the gateway.
Then incoming SCO socket file descriptor will be returned to PulseAudio.

	PulseAudio             BlueZ             oFono        AG
	|                        |                 |           |
	|   transport acquire    |                 |           |
	|----------------------->|                 |           |
	|                        |    request      |           |
	|                        |   connection    |           |
	|                        |---------------->|           |
	|                        |                 |  AT+BCC   |
	|                        |                 |..........>|
	|                        |                 |           |
	|                        |                 |     OK    |
	|                        |                 |<..........|
	|                        |                 |           |
	|                        |          connect SCO        |
	|                        |<............................|
	|      return SCO fd     |                 |           |
	|<-----------------------|                 |           |
	|                        |                 |           |

Incoming SCO connection - HFP HF - HFP v1.6
-------------------------------------------

Idem than for HFP v1.5

AT+NREC - HFP AG
----------------

Reception of AT+NREC will be signaled to Bluez by TelephonyClient.
This will update the NREC property of media transport interface (listened by
PulseAudio).

	HF          oFono            BlueZ         PulseAudio
	|   AT+NREC   |                |                |
	|............>|                |                |
	|             |    property    |                |
	|             | changed signal |                |
	|             |--------------->|                |
	|     OK      |                |    property    |
	|<............|                | changed signal |
	|             |                |--------------->|
	|             |                |                |

+BSIR - HFP AG
--------------

PulseAudio can change in-band ring tone by calling SetProperty method of media
transport interface.
This will call SetProperty of TelephonyClient interface, which will send the
proper +BSIR unsollicited event.

	HF          oFono            BlueZ         PulseAudio        app
	|             |                |                |             |
	|             |                |                |<------------|
	|             |                |  SetProperty   |             |
	|             |                |<---------------|             |
	|             |  SetProperty   |                |             |
	|             |<---------------|                |             |
	|   +BSIR:x   |                |                |             |
	|<............|                |                |             |
	|             |    property    |                |             |
	|             | changed signal |                |             |
	|             |--------------->|                |             |
	|             |                |                |             |

AT+VGS,AT+VGM - HFP AG
----------------------

Reception of volume management command will be signaled to Bluez by
TelephonyClient.
This will update the corresponding volume property of media transport interface
(listened by PulseAudio).

	HF          oFono            BlueZ         PulseAudio        app
	|             |                |                |             |
	|  AT+VGS=xx  |                |                |             |
	|............>|                |                |             |
	|             |    property    |                |             |
	|             | changed signal |                |             |
	|             |--------------->|                |             |
	|     OK      |                |                |             |
	|<............|                |    property    |             |
	|             |                | changed signal |             |
	|             |                |--------------->|             |
	|             |                |                |------------>|
	|             |                |                |             |

+VGS,+VGM - HFP AG
------------------

PulseAudio can change volume by calling SetProperty method of media transport
interface.
This will call SetProperty of TelephonyClient interface, which will send the
proper +VGx unsollicited event.

	HF          oFono            BlueZ         PulseAudio        app
	|             |                |                |             |
	|             |                |                |<------------|
	|             |                |  SetProperty   |             |
	|             |                |<---------------|             |
	|             |  SetProperty   |                |             |
	|             |<---------------|                |             |
	|   +VGS:xx   |                |    property    |             |
	|<............|                | changed signal |             |
	|             |    property    |--------------->|             |
	|             | changed signal |                |------------>|
	|             |--------------->|                |             |
	|             |                |                |             |

--------------030001090303030400070104
Content-Type: text/plain; charset=UTF-8;
 name="audio-api-new.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="audio-api-new.txt"

Telephony hierarchy
===================

Service		org.bluez
Interface	org.bluez.Telephony
Object path	[variable prefix]/{hci0,hci1,...}

Methods		void RegisterAgent(object path, dict properties)

			Register a TelephonyAgent to sender, the sender can
			register as many agents as it likes.
			Object path should be unique for an agent and a UUID.

			Note: If the sender disconnects its agents are
			automatically unregistered.

			possible properties:

				string UUID:

					UUID of the profile which the agent is
					for.

				uint16 Version:

					Version of the profile which the agent
					implements.

				uint16 Features:

					Agent supported features as defined in
					profile spec e.g. HFP.

			Possible Errors: org.bluez.Error.InvalidArguments

		void UnregisterAgent(object path)

			Unregister sender agent.

		dict GetProperties()

			Returns all properties for the interface. See the
			properties section for available properties.

			Possible Errors: org.bluez.Error.InvalidArguments

		void SetProperty(string name, variant value)

			Changes the value of the specified property. Only
			properties that are listed as read-write are changeable.
			On success this will emit a PropertyChanged signal.

			Possible Errors: org.bluez.Error.DoesNotExist
					 org.bluez.Error.InvalidArguments

Signals		void PropertyChanged(string name, variant value)

			This signal indicates a changed value of the given
			property.

Properties	boolean FastConnectable  [readwrite]

			Indicates if there is adapter in fast connectable mode.

TelephonyAgent hierarchy
========================

Service		unique name
Interface	org.bluez.TelephonyAgent
Object path	freely definable

Methods		object, dict properties NewConnection(filedescriptor fd,
		                                      dict properties)

			Returns a TelephonyClient object for the connection
			with its properties.

			This method gets called whenever a new connection
			has been established. This method assumes that D-Bus
			daemon with file descriptor passing capability is
			being used.

			The agent should only return successfully once the
			establishment of the service level connection (SLC)
			has been completed.  In the case of Handsfree this
			means that BRSF exchange has been performed and
			necessary initialization has been done.

			possible properties:

				object Device:

					BlueZ remote device object.

				uint16 Version:

					Remote profile version.

				uint16 Features:

					Optional. Remote profile features.

				string Codecs:

					Optional. List of supported audio
					codec ids separeted by a comma.

			Possible Errors: org.bluez.Error.InvalidArguments
					 org.bluez.Error.Failed

		void Release()

			This method gets called whenever the service daemon
			unregisters the agent or whenever the Adapter where
			the TelephonyAgent registers itself is removed.

TelephonyClient hierarchy
========================

Service		unique name
Interface	org.bluez.TelephonyClient
Object path	freely definable

Methods		dict GetProperties()

			Returns all properties for the interface. See the
			properties section for available properties.

			Possible Errors: org.bluez.Error.InvalidArguments

		void SetProperty(string name, variant value)

			Changes the value of the specified property. Only
			properties that are listed as read-write are changeable.
			On success this will emit a PropertyChanged signal.

			Possible Errors: org.bluez.Error.DoesNotExist
					 org.bluez.Error.InvalidArguments

		byte GetAudioCodec()

			Returns the codec to use for upcoming audio connection.
			This may start a new codec negotiation if needed.

Signals		void PropertyChanged(string name, variant value)

			This signal indicates a changed value of the given
			property.

		void AudioConnectionRequested()

			This signal indicates that remote has requested an audio
			connection.

Properties	byte	AudioCodec [readonly]

			Optional. Indicates the currently selected audio codec.

		boolean NREC [readwrite]

			Optional. Indicates if echo cancelling and noise
			reduction functions are active.

		boolean InbandRingtone [readwrite]

			Optional. Indicates if sending ringtones is supported.

		uint16 OutputGain  [readwrite]

			Optional. The speaker gain when available.

			Possible values: 0-15

		uint16 InputGain  [readwrite]

			Optional. The microphone gain when available.

			Possible values: 0-15

--------------030001090303030400070104--
