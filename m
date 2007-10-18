Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300710181026y23897b7eqb542f3adf7bfd35f@mail.gmail.com>
Date: Thu, 18 Oct 2007 11:26:02 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY117-W3751B12FFAA024B30DE551C09E0@phx.gbl>
MIME-Version: 1.0
References: <BAY117-W36EE4B29F3D4550A7C9847C09E0@phx.gbl>
	<d89ddf300710171849p3cd9da02kb7488387e095b534@mail.gmail.com>
	<BAY117-W28F4B89B2868D45873A26CC09E0@phx.gbl>
	<d89ddf300710180624r1970cc87p2ed1911a93a98c56@mail.gmail.com>
	<BAY117-W3751B12FFAA024B30DE551C09E0@phx.gbl>
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

semiyd,

fyi you get unpredictable behavior if you change stuff in
/var/lib/bluetooth manually.

brad

On 10/18/07, semiyd@hotmail.com <semiyd@hotmail.com> wrote:
>
> Hi Brad:
>        No , i didn't start up the passkey agent:)
>        In /etc/bluetooth/hcid.conf ,my configuration is "security auto;"
>        I manually created a file named 'pincodes' in /var/lib/bluetooth/XX:XX:XX:XX:XX:XX/ and put the linkcode
> in it . So that hcid will find the linkcode when requested by the headset.
>
> thanks
>
> semiyd

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
