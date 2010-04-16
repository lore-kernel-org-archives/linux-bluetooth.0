Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <572595.91160.qm@web94916.mail.in2.yahoo.com>
References: <572595.91160.qm@web94916.mail.in2.yahoo.com>
Date: Fri, 16 Apr 2010 11:02:29 +0300
Message-ID: <p2u2d5a2c101004160102uafada73az98db61259c9e2d21@mail.gmail.com>
Subject: Re: killing stalled ACL connection
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Pavan Savoy <pavan_savoy@yahoo.co.in>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Apr 15, 2010 at 10:25 PM, Pavan Savoy <pavan_savoy@yahoo.co.in> wrote:
> I am working on a platform which has a very aggressive power management features.
> So consider a situation, where an a2dp connection exists with a headset, and i pause the media over AVRCP, so my phone now goes into suspend state (shutting off UART clocks),
>
> and when I wake-up (resume) using the AVRCP connection, via the play/pause button, I see the platform waking up and media player receiving the input, However I also see this,
>
> hci0  ACL tx timeout.
> killing stalled ACL connection.
>
> and media is not able to play on the headset anymore.
> Although the media player thinks it's being played.
>
> Now where should I look into, as to why a perfectly nice ACL (l2cap, a2dp) connection was dropped during the suspend ?

I guess you mean the system is suspended, to be honest I thought that
would mean shutting down the bluetooth chip too which obviously will
drop all the connections, but that doesn't seems to be the case here,
does it? Anyway if you shutdown the bus which you communicate with the
chip it could eventually timeout, I guess in such situation it is
better to enter sniff mode, use some kind of bus that can
wakeup/powerup automatically if there is data to transfer or a
combination of both.


-- 
Luiz Augusto von Dentz
Computer Engineer
