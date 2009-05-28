Return-Path: <cyrus@holtmann.org>
Message-ID: <D8ED1515996C4CC4A0F8469E566A13E2@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: <linux-bluetooth@vger.kernel.org>
Subject: AVRCP Metadata use-case question
Date: Thu, 28 May 2009 14:40:27 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel, Johan (and others interested):

I am adding the first-cut Metadata extensions, and will be testing this 
weekend.

I need to add a couple of methods to the previous interface doc.

*  SetCompanyID will identify additional CompanyIDs supported by the 
Target (in addition to the standard BTSig 001958).  This would be used 
to indicate that a target would support additional Passthrough and 
Vendor Dependent messages and methods.  Input parameter for the Dbus 
method will be an array of unsigned ints, which will be transformed and 
packed to three-byte integers in the GetCapabilities response to the 
Controller(s).  If the caller supplies the BTSig CompanyID, it will be 
ignored.

*  SetEnabledEvent will identify notification event types supported by 
the Target, in addition to TrackChanged and PlaybackStatusChanged which 
are mandatory.   Here the Input Parameter will be either an array of 
unsigned bytes (0x01 to 0x08, corresponding to the EventIDs assigned to 
each event in the spec), or an array of strings, with "friendly" names 
for each event.  Do either of you have any preference either way?  Like 
the SetCompanyID, the array of strings will be converted to an array of 
bytes (could even be a bit-mask), signifying the events enabled.  In any 
response to a GetCapabilities query from the Controller(s), the enabled 
event capabilities will be transmitted as a list of byte-sized EventIDs, 
one for each capability that is supported and enabled by the Target.

I mention "Controllers" as opposed to Controller, because it appears 
that the Bluez model implements a single Controller talking to a single 
Target (running on the BlueZ/Linux box).  Now, with the addition of the 
VolumeUp and VolumeDown methods, the BlueZ box is taking on a Controller 
role, talking to a headset to adjust its volume.  But still, one 
Controller, one Target.  And, if there are multiple controllers and 
multiple targets, they are still one-to-one (or n-to-n), and each 
connection is independent of all the others.

My particular usage allows for multiple Controllers and a single Target 
(simplifying a bit here).  As a result, the one Target (the BlueZ box) 
will report the same Company ID(s) and the same enabled Events for all 
Controllers talking to it, and hence, for all of the sessions between 
those Controllers and the Target.  Also, since that one Target is 
playing one stream of music for all (as opposed to multiple concurrent 
streams), there is only one track being played and one set of Track 
Metadata active at any one time.

I am considering that in the first setup process for AVRCP for any 
Controller-Target session, when the application sets the CompanyIDs and 
EnabledEvents, it would do this once, and that setup would be globally 
available to all future sessions, saving the overhead of doing this for 
every session.  Similarly, when the track changes, the Track Metadata 
would be updated once for all channels at the same time, rather than 
updating each session individually with that metadata.

Further (not sure how familiar you are with the details of AVRCP v1.3). 
These values are not tranmitted to the Controllers immediately, but are 
just kept available until each controller requests that information via 
a Vendor Dependent message (in the case of the Track Metadata query, in 
response to a TrackChanged event).

Do you see any issues with setting up global Company IDs, Enabled 
Events, and Track Metadata?  Or am I going down a wrong path?

Thanks in advance,

David Stockwell
Frequency One


