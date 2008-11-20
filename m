Return-Path: <cyrus@holtmann.org>
From: "Liu, Raymond" <raymond.liu@intel.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>, Vinicius Gomes
	<vinicius.gomes@openbossa.org>
Date: Thu, 20 Nov 2008 16:27:10 +0800
Message-ID: <0463F45F3606F4428ED35AC8C709F92E0217A293@pdsmsx502.ccr.corp.intel.com>
References: <0463F45F3606F4428ED35AC8C709F92E0217A025@pdsmsx502.ccr.corp.intel.com>
	<2a9506370811192003u1c3d7f27qe50472922b7b33@mail.gmail.com>
	<0463F45F3606F4428ED35AC8C709F92E0217A0CC@pdsmsx502.ccr.corp.intel.com>
	<0463F45F3606F4428ED35AC8C709F92E0217A0E4@pdsmsx502.ccr.corp.intel.com>
In-Reply-To: <0463F45F3606F4428ED35AC8C709F92E0217A0E4@pdsmsx502.ccr.corp.intel.com>
MIME-Version: 1.0
Cc: "johan.hedberg@nokia.com" <johan.hedberg@nokia.com>
Subject: Re: [Bluez-devel] could not uses introspect in obexd client for
 session or ftp from the root path.
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
Errors-To: bluez-devel-bounces@lists.sourceforge.net

>>>Using this trick I was able to verify that the
>>>"/org/openobex/session0" node is being added to
>>>the bus, it is just not being added as a child of the "/" node, but in
>>>parallel to it.
>>
>>Yes, I try it out. It a good tool, Thanks!
>>However, as you said, it will not recognize the node under "/", I am wondering,
>>is that because we do not provide the introspect info for child node , or just
>>the bad of this tool? So user who use d-feet still could not find our secret
>>interface :)
>
>Hi, I just try out /org/freedesktop/Hal, it also employ a set of child nodes
>under "/" path, however, d-feet can read them out correctly, So I guess, for
>obexd, the reason it do not work is because we do not provide the child node
>info in the "/"'s introspect method. Not the bad of d-feet tool
>

Really strange, Thanks for johan's help, I notice that bluez's introspect method work for the child node too, it can show the adapter's interface correctly. And the gdbus dir of bluez and obexd is almost the same! I have double check for several times, then why one is working while another don't? 

Raymond

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
