Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <40AD87B3.6020805@mail.ru>
From: Alexander Kulakov <a.kulakov@mail.ru>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] Fujitsu-Siemens Celsius
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
Date: Thu, 20 May 2004 22:38:11 -0600

Hi all,

Recently I was given a new Fujitsu-Siemens "Celsius Mobile H". I have 
some experience in installing and using laptops with Linux but this one 
has very special detail - its keyboard with integrated touch pad is 
removable. That is, it has bluetooth interface and it can be easily 
"undocked".
The problem is that it works nice until I start Linux hotplug subsystem. 
Of course, I spent some time trying to find solution in several places 
like google and Linux related mailing-list archives.
Whatever I try to do I cannot bring bluetooth device up. I dont even see 
any presence of it. I tried to update BIOS, use 2.4 and 2.6 kernels + 
patches from bluez.sf.net. The result is the same - whichever modules I 
load "hcitools dev" command from bluez-utils package shows no any 
device. It seems like I dont have any bt device at all.

I'd appreciate any advice what it could be.
BTW, It works perfectly with WinXP Pro SP1 (I have to have it on my 
laptop - company policy :( )



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
