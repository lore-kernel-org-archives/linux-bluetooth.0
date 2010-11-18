Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCHv3 3/7] Add DBus OOB API documentation.
Date: Thu, 18 Nov 2010 11:51:48 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1289922247-20712-1-git-send-email-szymon.janc@tieto.com> <20101116163729.GA3854@jh-x301> <201011171349.51512.szymon.janc@tieto.com>
In-Reply-To: <201011171349.51512.szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201011181151.48796.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> > > +Service         org.bluez
> > > +Interface       org.bluez.OOB
> > > +Object path     /org/bluez
> > 
> > I think this should use the same path as the Manager API, which at the
> > moment is /
> 
> I was following HealthManager way, but I'm fine if you prefer / path.
> 
> > > +		array{byte} hash, array{byte} randomizer
> > > +			ReadLocalOobData(object adapter)
> > 
> > Having to pass an adapter path as a parameter seems weird. Wouldn't it
> > make more sense to have this method in the Adapter path/interface
> > instead? Also, we could toy around with the thought of putting the two
> > other methods into the current Manager interface.
> 
> It is OK to me to move ReadLocalOobData to adapter path as this is an adapter
> related data.
> 
> My initial idea was to keep all oob related methods in org.bluez.OOB interface
> but I'm not going to insist on it.

Please see the following proposal.

Register/UnregisterProvider methods can be easily moved to manager interface if
decided (with name changes to i.e. RegisterOobProvider for clarity).

Moving ReadLocalOobData to adapter path requires some code changes in dbusoob
plugin so I prefer to clarify that before coding.


Any comments?


BlueZ D-Bus OOB API description
*******************************

Copyright (C) 2010  ST-Ericsson SA

Author: Szymon Janc <szymon.janc@tieto.com> for ST-Ericsson

OOB hierarchy
=================

Service         unique name
Interface       org.bluez.OOB
Object path     freely definable

Methods		array{byte} hash, array{byte} randomizer
			RequestRemoteOobData(object device)

			This method gets called when the service daemon needs to
			get device's hash and randomizer for an OOB
			authentication. Each array should be 16 bytes long.

			Possible errors: org.bluez.Error.NoData

		void Release()

			This method gets called when D-Bus plug-in for OOB was
			deactivated. There is no need to unregister provider,
			because when this method gets called it has already been
			unregistered.

--------------------------------------------------------------------------------

Service         org.bluez
Interface       org.bluez.OOB
Object path     /

Methods		void RegisterProvider(object provider)

			This method registers provider for D-Bus OOB plug-in.
			When provider is successfully registered plug-in becomes
			active. Only one provider can be registered at time.

			Possible errors: org.bluez.Error.AlreadyExists

		void UnregisterProvider(object provider)

			This method unregisters provider for D-Bus OOB plug-in.

			Possible errors: org.bluez.Error.DoesNotExist

--------------------------------------------------------------------------------

Service		org.bluez
Interface	org.bluez.Adapter
Object path	[variable prefix]/{hci0,hci1,...}

		array{byte} hash, array{byte} randomizer ReadLocalOobData()

			This method reads local OOB data for adapter. Return
			value is pair of arrays 16 bytes each. Only registered
			provider should call this method. This method is
			available only for 2.1 (or higher) adapters.

			Note: This method will generate and return new local
			OOB data.

			Possible errors: org.bluez.Error.ReadFailed
					 org.bluez.Error.NoProvider
					 org.bluez.Error.InProgress

--------------------------------------------------------------------------------

Service		unique name
Interface	org.bluez.Agent
Object path	freely definable

Methods		void RequestPairingApproval(object device)

			This method gets called when the service daemon
			needs to confirm incoming OOB pairing request.

			Possible errors: org.bluez.Error.Rejected
					 org.bluez.Error.Canceled



-- 
Szymon Janc
on behalf of ST-Ericsson
