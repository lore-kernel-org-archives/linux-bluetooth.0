Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <1089262620.40ecd41c49ef3@imp.webmail.hku.hk>
From: h0016530@hkusua.hku.hk
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Questions about Role Changing during PAN setup
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu,  8 Jul 2004 12:57:00 +0800

I'm using PAN daemon version 1.1rc2. The role of server is always "PANU" after I
ahve tried to declare and change it to NAP by "pand --listen --role NAP
--service --sdp --master" and "pand --listen --role NAP". This is what I got:
# pand --show
bnep0 00:02:C7:18:25:A0 PANU
Secondly, I failed to use ftp even after the server(PC) and client(iPAQ)
cnonects to each other at the IP layer. Here is what I recieved from the
server:
#sftp 10.0.0.2
Connecting to 10.0.0.2...
root@10.0.0.2's password:
Request for subsystem 'sftp' failed on channel 0
Connection closed

Can anyone gives me some advice?

Thank you very much!

--
Katie 





-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
