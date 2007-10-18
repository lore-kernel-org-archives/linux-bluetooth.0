Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300710180624r1970cc87p2ed1911a93a98c56@mail.gmail.com>
Date: Thu, 18 Oct 2007 07:24:58 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY117-W28F4B89B2868D45873A26CC09E0@phx.gbl>
MIME-Version: 1.0
References: <BAY117-W36EE4B29F3D4550A7C9847C09E0@phx.gbl>
	<d89ddf300710171849p3cd9da02kb7488387e095b534@mail.gmail.com>
	<BAY117-W28F4B89B2868D45873A26CC09E0@phx.gbl>
Subject: Re: [Bluez-devel] SCO connection timed out issue
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

semiyd

> hcid[318]: link_key_request (sba=00:80:E1:00:00:00, dba=00:0D:3C:EB:53:F0)
> hcid[318]: link_key_request (sba=00:80:E1:00:00:00, dba=00:0D:3C:EB:53:F0)

did you start up a passkey agent? under some setups I have to do this manually:

passkey-agent --default 0000 &

brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
