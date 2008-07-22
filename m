Return-Path: <cyrus@holtmann.org>
Message-ID: <4885C0C9.7000308@idlum.be>
Date: Tue, 22 Jul 2008 13:13:13 +0200
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Unexpected error / chronology trying to extract sdp
	handles
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

Hello,

I'm running v3.34. I know it's not the latest. But I've observed what I 
describe below on virtually any previous 3.x version.

Somewhere in my code, I perform a call to 
Adapter.GetRemoteServiceHandles(btAddress, match). This call blocks as 
expected. A few seconds later, I get a RemoteDeviceConnected signal. 
Great, looking good. But about 30s after the first call, 
GetRemoteServiceHandles finally returns, by throwing a 
ConnectionAttemptFailed. The RemoteDeviceDisconnected event arrives at 
the same time than the expection.

How can I get I get a ConnectionAttempFailed while I have received a 
"Connected" signal previously? Is it to be expected? How should such 
apparent non-sense be dealt with? Or perhaps I'm mislead by the 
(apparently obvious) "ConnectionAttemptFailed" name?

Thanks in advance,
Best Regards.
Pierre-Yves

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
