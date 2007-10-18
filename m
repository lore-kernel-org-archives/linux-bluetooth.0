Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <BAY117-W3751B12FFAA024B30DE551C09E0@phx.gbl>
From: "" <semiyd@hotmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Thu, 18 Oct 2007 13:46:25 +0000
In-Reply-To: <d89ddf300710180624r1970cc87p2ed1911a93a98c56@mail.gmail.com>
References: <BAY117-W36EE4B29F3D4550A7C9847C09E0@phx.gbl>
	<d89ddf300710171849p3cd9da02kb7488387e095b534@mail.gmail.com>
	<BAY117-W28F4B89B2868D45873A26CC09E0@phx.gbl>
	<d89ddf300710180624r1970cc87p2ed1911a93a98c56@mail.gmail.com>
MIME-Version: 1.0
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
Content-Type: multipart/mixed; boundary="===============0727888459=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0727888459==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Brad:
       No , i didn't start up the passkey agent:)
       In /etc/bluetooth/hcid.conf ,my configuration is "security auto;"
       I manually created a file named 'pincodes' in /var/lib/bluetooth/XX:XX:XX:XX:XX:XX/ and put the linkcode
in it . So that hcid will find the linkcode when requested by the headset.

thanks

semiyd


> Date: Thu, 18 Oct 2007 07:24:58 -0600
> From: bmidgley@gmail.com
> To: bluez-devel@lists.sourceforge.net
> Subject: Re: [Bluez-devel] SCO connection timed out issue
>
> semiyd
>
>> hcid[318]: link_key_request (sba=00:80:E1:00:00:00, dba=00:0D:3C:EB:53:F0)
>> hcid[318]: link_key_request (sba=00:80:E1:00:00:00, dba=00:0D:3C:EB:53:F0)
>
> did you start up a passkey agent? under some setups I have to do this manually:
>
> passkey-agent --default 0000 &
>
> brad
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems? Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now>> http://get.splunk.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

_________________________________________________________________
Invite your mail contacts to join your friends list with Windows Live Spaces. It's easy!
http://spaces.live.com/spacesapi.aspx?wx_action=create&wx_url=/friends.aspx&mkt=en-us


--===============0727888459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0727888459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0727888459==--
