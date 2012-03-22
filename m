Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAB7rCTiQiaFRqDOj6OGZPfTtBWSnR60ADAZimEZJ=F0Tf0-R4Q@mail.gmail.com>
References: <CAB7rCTiQiaFRqDOj6OGZPfTtBWSnR60ADAZimEZJ=F0Tf0-R4Q@mail.gmail.com>
Date: Thu, 22 Mar 2012 14:18:37 -0300
Message-ID: <CABBYNZLp3U9sHqiaW9xcH1f8qfrkM7t181y8NVK5L+Rwxet5jw@mail.gmail.com>
Subject: Re: media transport -- when is acquire ok to call?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mike <puffy.taco@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

On Wed, Mar 21, 2012 at 4:02 PM, Mike <puffy.taco@gmail.com> wrote:
> I'm having some trouble with MediaEndpoint/MediaTransport and A2DP.
> When I get the "SetConfiguration" call, I wait 2 seconds and then call
> "Acquire", generally giving BlueZ enough time get the D-Bus interface
> ready to go.  However, the delay isn't always long enough.  Shown
> below is a time when my phone is attempting to pair with BlueZ.  The
> error "org.bluez.Error.NotAuthorized" is output from my application.
> In this case, the problem is that the audio source is still in the
> CONFIGURED state, not in the OPEN state.  Is there a recommended
> method of how long to wait before calling acquire?  Or should I rely
> on the AudioSource "State" property to become connected (or playing)?
> Is there any reason I can't get the transport when in the Configured
> state (does the fd not exist yet?)?  Or why is "a2dp_resume" being
> called on open (which is what is rejecting my acquire call)?

In case of PA we do wait for Audio.Connected property before loading
the module which does call MediaTransport.Acquire, but 2 seconds is
too much there might be something else holding the setup, do you reply
right away the SetConfiguration, if you do try to Acquire while
bluetoothd is waiting you to reply it might fail.

> bluetoothd[751]: audio/avdtp.c:avdtp_parse_cmd() Received OPEN_CMD
> bluetoothd[751]: audio/a2dp.c:open_ind() Sink 0x2a0d40a8: Open_Ind
> bluetoothd[751]: audio/transport.c:media_transport_acquire() Transport
> /org/bluez/751/hci0/dev_00_17_E3_3B_4F_DD/fd1: read lock acquired
> bluetoothd[751]: audio/transport.c:media_transport_acquire() Transport
> /org/bluez/751/hci0/dev_00_17_E3_3B_4F_DD/fd1: write lock acquired
> bluetoothd[751]: audio/transport.c:media_owner_create() Owner created:
> sender=:1.40 accesstype=rw
> bluetoothd[751]: audio/avdtp.c:avdtp_ref() 0x2a0d2a00: ref=3
> bluetoothd[751]: audio/transport.c:media_transport_release() Transport
> /org/bluez/751/hci0/dev_00_17_E3_3B_4F_DD/fd1: read lock released
> bluetoothd[751]: audio/transport.c:media_transport_release() Transport
> /org/bluez/751/hci0/dev_00_17_E3_3B_4F_DD/fd1: write lock released
> bluetoothd[751]: audio/transport.c:media_owner_free() Owner :1.40
> getting the reply from the cb failed
> GDBus.Error:org.bluez.Error.NotAuthorized: Operation Not Authorized

Strange, if what you said is true why there is no "SEP in bad state
for resume" error? Anyway I think we can fix this by checking the
current state of the SEP and waiting it to go OPEN to resume, so the
client don't have to keep tracking of Audio.Connected.


-- 
Luiz Augusto von Dentz
