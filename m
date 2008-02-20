Return-Path: <cyrus@holtmann.org>
Message-ID: <255b859d0802191819k70b0cd41i39371e825119260c@mail.gmail.com>
Date: Tue, 19 Feb 2008 18:19:09 -0800
From: "Peter Hollenbeck" <pwhbeck@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300802191541y3912b4feie451f20550ffbbb3@mail.gmail.com>
MIME-Version: 1.0
References: <255b859d0802171852g2677eb74o3605150a07ac084@mail.gmail.com>
	<d89ddf300802191541y3912b4feie451f20550ffbbb3@mail.gmail.com>
Subject: Re: [Bluez-users] Multiple Earphone/Mic Headsets Intercom
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1213271748=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1213271748==
Content-Type: multipart/alternative;
	boundary="----=_Part_13039_10552939.1203473949666"

------=_Part_13039_10552939.1203473949666
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I think I understand.
Thanks very much.
Peter

On Feb 19, 2008 3:41 PM, Brad Midgley <bmidgley@gmail.com> wrote:

> Peter
>
> On Feb 17, 2008 7:52 PM, Peter Hollenbeck <pwhbeck@gmail.com> wrote:
> > I know only a little about Bluetooth and BlueZ. I am interested in
> building
> > an intercom that allows four headsets (phone and mic) to
> intercommunicate.
> > The Bluetooth intercom profile appears to allow for only two devices. Is
> > this so and does it apply to the BlueZ implementation?
>
> you won't be able to have more than three sco connections
> simultaneously through one bluetooth adapter. If your bluetooth
> adapter is usb-connected it will take a kernel patch to get multiple
> simultaneous connections. If it's uart-connected (typical for
> embedded) then it will work without patching.
>
> either way you will be writing your own userspace software to copy
> audio around and negotiate connections.
>
> --
> Brad
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_13039_10552939.1203473949666
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I think I understand.<br>Thanks very much.<br>Peter<br><br><div class="gmail_quote">On Feb 19, 2008 3:41 PM, Brad Midgley &lt;<a href="mailto:bmidgley@gmail.com">bmidgley@gmail.com</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Peter<br><div><div></div><div class="Wj3C7c"><br>On Feb 17, 2008 7:52 PM, Peter Hollenbeck &lt;<a href="mailto:pwhbeck@gmail.com">pwhbeck@gmail.com</a>&gt; wrote:<br>&gt; I know only a little about Bluetooth and BlueZ. I am interested in building<br>
&gt; an intercom that allows four headsets (phone and mic) to intercommunicate.<br>&gt; The Bluetooth intercom profile appears to allow for only two devices. Is<br>&gt; this so and does it apply to the BlueZ implementation?<br>
<br></div></div>you won&#39;t be able to have more than three sco connections<br>simultaneously through one bluetooth adapter. If your bluetooth<br>adapter is usb-connected it will take a kernel patch to get multiple<br>simultaneous connections. If it&#39;s uart-connected (typical for<br>
embedded) then it will work without patching.<br><br>either way you will be writing your own userspace software to copy<br>audio around and negotiate connections.<br><br>--<br>Brad<br><br>-------------------------------------------------------------------------<br>
This SF.net email is sponsored by: Microsoft<br>Defy all challenges. Microsoft(R) Visual Studio 2008.<br><a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target="_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>
_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>
</blockquote></div><br>

------=_Part_13039_10552939.1203473949666--


--===============1213271748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1213271748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1213271748==--
