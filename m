Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 8 Mar 2012 18:09:38 -0600
Message-ID: <CAB7rCThRVZmGensz_bv6rFFS5Pf_BvOiVW4dFjmC6KkoVLgvXQ@mail.gmail.com>
Subject: obtain HFP disconnection event reason code
From: Mike <puffy.taco@gmail.com>
To: linux-bluetooth@vger.kernel.org, ofono@ofono.org
Reply-To: ofono@ofono.org
List-Unsubscribe: <http://lists.ofono.org/options/ofono>,
	<mailto:ofono-request@ofono.org?subject=unsubscribe>
List-Archive: <http://lists.ofono.org/pipermail/ofono>
List-Post: <mailto:ofono@ofono.org>
List-Help: <mailto:ofono-request@ofono.org?subject=help>
List-Subscribe: <http://lists.ofono.org/listinfo/ofono>,
	<mailto:ofono-request@ofono.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: ofono-bounces@ofono.org
Errors-To: ofono-bounces@ofono.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to act like a better headset in the HFP HF role, I am in need
of the reason code from the disconnection event.  This is so that I
can detect when a disconnect occurs as a result of the units moving
out of range of each other, rather than an intentional disconnect.  In
the event of a disconnection based on connection loss, I can then
periodically re-attempt the connection.  I have not seen any D-Bus
messages that would indicate such an event.

Any ideas on how to obtain this?  I can see that in the hciops version
of bluez, the reason code makes it into bluetoothd just because the
entire disconnect event is transferred.  This is not the case in the
mgmtops version.  It looks like the reason code also hops along the
L2CAP path, but I haven't yet tracked down where it ends up.  I think
ideally it would end up somewhere that Ofono would be able to obtain
it.

Thanks,
Mike
_______________________________________________
ofono mailing list
ofono@ofono.org
http://lists.ofono.org/listinfo/ofono
