Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: HDP proposed api (ver 0.2)
Date: Mon, 10 May 2010 10:42:50 +0200
Cc: Elvis =?iso-8859-1?q?Pf=FCtzenreuter?= <epx@signove.com>,
	=?iso-8859-1?q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>,
	linux-bluetooth@vger.kernel.org
References: <201005051255.09394.jcaden@libresoft.es> <32F45991-49B0-4B46-84C0-789A3B1D8766@signove.com> <AANLkTimz7yYXB2gV0EyRROItnIP6hILvC8Tz4Hbd0iyx@mail.gmail.com>
In-Reply-To: <AANLkTimz7yYXB2gV0EyRROItnIP6hILvC8Tz4Hbd0iyx@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005101042.50984.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

El Sunday 09 May 2010 17:14:39 Luiz Augusto von Dentz escribió:
> Hi,
> 
> On Sat, May 8, 2010 at 12:08 AM, Elvis Pfützenreuter <epx@signove.com> 
wrote:
> >> Device objects exists for each paired device. If the pairing is
> >> removed the object is also removed and a new pairing is needed before
> >> connecting to it (as imposed by the whole bluetooth stack logic
> >> anyway).
> > 
> > AFAIK the HDP source and sink must be paired before any session can be
> > established, so the relevant device objects will always be there, so the
> > path can be (re)used.
> 
> Exactly, I tried to explain this before that device objects is a
> better way to expose any relevant API since that would be created
> anyway. It also has integration with the sdp record cache and are
> reloaded during the initialization and I hardly see us doing anything
> to revert this, since pretty much every plugin depend on this to work.

We agree that the best way to expose a remote device is using the path 
already created by bluez. We are thinking, as Elvis suggested, in changing
some functions to that path for discovering remove services.

The main problem here is that sessions exist in HDP even if bluez is not 
concerned about them. Imagine that we perform an implementation without 
session management, this not implies that other implementations do the same so 
a remote device could expose multiple HDP session (each one of them could 
expose a SDP record). Now if you are not concern of the sessions and you try 
to connect to a remote device that holds more than one session, you can't 
decide which one of that sessions connect. A simple example of this situation 
is described in the HDP implementation whitepaper (page 18, figure 2.4).

> 
> So, with this in mind, IMHO, the whole concept of exposure the
> sessions won't fit nicely in BlueZ API, first because it uses the
> adapter path to create session passing a device path, which btw
> already is associated with adapter anyway, 

We think that the main problem here is that we don't choose a good path name. 
But we are open to suggestion for a better one.

> second because any client
> seems to be able to create those sessions even if they are unable to
> control them because they don't hold an agent,

We think that this is not a good reason, the same could happend with other 
profiles. Any client could connect to an Audio or Serial device even if they 
are unable to use them or the don't know how to do it.

> and third I don't think
> we should be exposing protocol internals in a D-Bus API,

We don't understand this. What do you mean with protocol internal? Nothing 
exposed in D-Bus in internal we just propose to concert the client about the 
remote session (remote hdp instance) because it need to decide with one to 
connect, as it decides the device that it will connect with a Serial 
connection. Probably we need a better name than "session id".

> this id's
> make as much sense as the bdaddr in the ui (read _none_), it is as
> usable as we starting exposing local and remote seid (Stream Endpoint
> id, surprisingly similar to endpoint here) to pulseaudio to carry on
> with all avdtp protocol details, this will only fragment the logic
> around those bits and certainly won't make it work better.

Ok, we shouldn't expose mdepid. But we still need to expose the remote hdp 
session or instances. Note that in Audio profile the psm is fixed, so there is 
just one listening on each device, but HDP is different because the psm are not 
fixed and multiple instances can exist in  the same device.



