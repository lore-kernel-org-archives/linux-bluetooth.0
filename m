Return-Path: <cyrus@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Message-Id: <20080209072942.BB31B3BD2A@xena.cft.ca.us>
Date: Fri,  8 Feb 2008 23:29:42 -0800 (PST)
From: jimc@math.ucla.edu (Jim Carter)
Subject: [Bluez-devel] Audio service starts bogus copy of hcid
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Using bluez-utils-3.25, I try to do:
    aplay -D bluetooth file.wav
It says: audio open error: Input/output error.  Numerous other
applications have similar but more complicated failures.  None ever 
work.  Restarting hcid, resetting the transceiver or rebooting the
machine have no effect.

In syslog I find this sequence (after reasonable-looking startup
messages for hcid and bluetoothd-service-audio, which are the instances
in /usr/local/sbin from bluez-utils-3.25, not the ones from 3.18 from my
distro, SuSE 10.3).  

audio[13196]: Accepted new client connection on unix socket (fd=9)
audio[13196]: Audio API: received BT_GETCAPABILITIES_REQ
audio[13196]: avdtp_ref(0x806a000): ref=2
hcid[13234]: Bluetooth HCI daemon
hcid[13234]: Could not become the primary owner of org.bluez
hcid[13234]: Unable to get on D-Bus
hcid[13192]: link_key_request (sba=00:19:7E:E7:A7:11, dba=00:07:A4:F1:C8:E9)
audio[13196]: connect(): Software caused connection abort (103)

See how a bogus instance of hcid starts up, then (obviously) fails to
serve the connection for the audio service?  Of course 13234 cannot
seize org.bluez because 13192 already owns it.  I can't even tell if
it's the correct version [suggestion: include the version in the splash
message] or figure out where it's being started.  The link key request
is from the leader hcid thread, and the btaddrs are for the laptop's
transceiver and the Motorola HT820 headphone.

I used "strace -f" to start up a new instance of hcid (producing the
above syslog output), and I was able to find what happened right after
it syslogged "avdtp_ref..." (13196 is the audio service):

13196 socket(PF_BLUETOOTH, SOCK_SEQPACKET, 0) = 10
13196 bind(10, {sa_family=AF_BLUETOOTH, sa_data="\0\0\21\247\347~\31
	\0\0\240\6\10\0\240"}, 10) = 0
(sets flags)
13196 connect(10, {sa_family=AF_BLUETOOTH, sa_data="\31\0\351\310\361
	\244\7\0\0\240\6\10\0\240"}, 10) = -1 EINPROGRESS (Operation 
	now in progress)
13196 poll( <unfinished ...>

After which 13192 (the real hcid) handles the link key request and
13196 reports the connection abort.  But 13234 (the interloper hcid)
is not seen at all by strace.  Very mysterious.  

Does anyone have any ideas here?

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
