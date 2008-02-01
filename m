Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Feb 2008 13:07:27 -0800 (PST)
From: "Russell A. Bell" <rbell@alumnus.caltech.edu>
Message-Id: <200802012107.m11L7Rve012990@alumnus.caltech.edu>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] unique bus name
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

	'I think that error could be caused by you not having a local
SDP server running. You should either have sdpd running or have
started hcid with the -s switch (the preferred way).'

 	Running 'bluetoothd-service-audio -s' with an sdpd server
loaded returns:

audio[9417]: Bluetooth Audio daemon
audio[9417]: Config options: DisableHFP=true, SCORouting=PCM, SourceCount=2
audio[9417]: Unix socket created: 5
audio[9417]: add_service_record: got record id 0x10000
audio[9417]: add_service_record: got record id 0x10001
audio[9417]: add_service_record: got record id 0x10002
audio[9417]: add_service_record: got record id 0x10003
audio[9417]: Registered manager path:/org/bluez/audio
audio[9417]: Registering service
audio[9417]: Can't register service

	hcidump shows some action, but no reference to a specific
device: where does bluetoothd-service-audio look to find devices to
which to connect?

russell bell


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
