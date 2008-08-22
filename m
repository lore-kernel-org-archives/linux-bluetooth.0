Return-Path: <cyrus@holtmann.org>
To: bluez-devel@lists.sourceforge.net
From: Jui-Hao Chiang <windtracekimo@gmail.com>
Date: Fri, 22 Aug 2008 02:41:55 +0000 (UTC)
Message-ID: <loom.20080822T022926-635@post.gmane.org>
Mime-Version: 1.0
Subject: [Bluez-devel] Problem automatic flush timeout
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,
Is there a way to simulate unreliable L2CAP socket in a client-server scenario?
(two PCs, each with single adapter; client sends 48 bytes packet to server every
1 second)
After establishing a L2CAP between two adapters, I tried to set the "automatic
flush timeout" on the client adapter with timeout to be 2. The hci_send_req is
successful, but after 7 to 8 seconds, the server adapter stops to receive any
data while client socket is still sending data. If I set it timeout to 4, then
everything is fine.

What I am imagining is "some data on client adapter may be flushed, but the
later packet should continue to be sent to server adapter".
Am I doing something wrong?

    // build a command packet to send to the bluetooth microcontroller
    cmd_param.handle = connection_handle;
    cmd_param.flush_timeout = htobs(timeout);
    rq.ogf = OGF_HOST_CTL;
    rq.ocf = 0x28;
    rq.cparam = &cmd_param;
    rq.clen = sizeof(cmd_param);
    rq.rparam = &cmd_response;
    rq.rlen = sizeof(cmd_response);
    rq.event = EVT_CMD_COMPLETE;

    // send the command and wait for the response
    err = hci_send_req( dd, &rq, 0 );
    if( err ) goto cleanup;



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
