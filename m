Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <194c6ea30710181924x2de24e87i7df6352a7114f5b9@mail.gmail.com>
Date: Fri, 19 Oct 2007 10:24:58 +0800
From: "dong yan" <semiydsemiyd@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d89ddf300710181026y23897b7eqb542f3adf7bfd35f@mail.gmail.com>
MIME-Version: 1.0
References: <BAY117-W36EE4B29F3D4550A7C9847C09E0@phx.gbl>
	<d89ddf300710171849p3cd9da02kb7488387e095b534@mail.gmail.com>
	<BAY117-W28F4B89B2868D45873A26CC09E0@phx.gbl>
	<d89ddf300710180624r1970cc87p2ed1911a93a98c56@mail.gmail.com>
	<BAY117-W3751B12FFAA024B30DE551C09E0@phx.gbl>
	<d89ddf300710181026y23897b7eqb542f3adf7bfd35f@mail.gmail.com>
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

Hi Brad:
      You are right.I launched passkey-agent with the command
"passkey-agent --default 8888 &". After that ,i deleted the headset
related linkcode in the /var/lib/bluetooth/XX:XX:XX:XX:XX:XX/pincodes.
Now hcid looks for the linkcode from passkey-agent.
Here:
hcid[306]: link_key_request (sba=00:80:E1:00:AB:BA,
dba=00:0D:3C:EB:53:F0) hcid[306]: pin_code_request
(sba=00:80:E1:00:AB:BA, dba=00:0D:3C:EB:53:F0) hcid[306]: Calling
PasskeyAgent.Request: name=:1.3, path=/org/bluez/passkey_agent_328
Passkey request for device 00:0D:3C:EB:53:F0
hcid[306]: link_key_notify (sba=00:80:E1:00:AB:BA, dba=00:0D:3C:EB:53:F0)
hcid[306]: link_key_request (sba=00:80:E1:00:AB:BA,
dba=00:0D:3C:EB:53:F0) The pairing procedure to the headset is now
handled by passkey-agent. Seems like hcid will search the linkcode
firstly in that 'pincodes' file. If he didn't find one ,he will turn
to the passkey-agent and ask for the code.

thanks

 semiyd

2007/10/19, Brad Midgley <bmidgley@gmail.com>:
> semiyd,
>
> fyi you get unpredictable behavior if you change stuff in
> /var/lib/bluetooth manually.
>
> brad
>
> On 10/18/07, semiyd@hotmail.com <semiyd@hotmail.com> wrote:
> >
> > Hi Brad:
> >        No , i didn't start up the passkey agent:)
> >        In /etc/bluetooth/hcid.conf ,my configuration is "security auto;"
> >        I manually created a file named 'pincodes' in /var/lib/bluetooth/XX:XX:XX:XX:XX:XX/ and put the linkcode
> > in it . So that hcid will find the linkcode when requested by the headset.
> >
> > thanks
> >
> > semiyd
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
