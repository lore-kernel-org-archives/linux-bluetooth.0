Return-Path: <cyrus@holtmann.org>
Message-ID: <8f5c4ad0802050338m771e8783x1974173ef7588685@mail.gmail.com>
Date: Tue, 5 Feb 2008 17:08:54 +0530
From: "george keane" <chemvell@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300802010833p34cb076cs3fa1ef394f8b730c@mail.gmail.com>
MIME-Version: 1.0
References: <8f5c4ad0802010514p6c52938fy173541c9600ea55f@mail.gmail.com>
	<d89ddf300802010833p34cb076cs3fa1ef394f8b730c@mail.gmail.com>
Subject: Re: [Bluez-users] Infineon PBA31308
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1730370334=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1730370334==
Content-Type: multipart/alternative;
	boundary="----=_Part_7699_9924709.1202211534770"

------=_Part_7699_9924709.1202211534770
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Brad,
      Thanks for your quick reply.I had a quick look(as i dont have a lot of
time to bring the 31308 up..:-(. at the gumstix site and had gone through
the hciattach patches found there. now I have a patch which was used by a
balckfin team on muClinux.(Almost same as the gumstix one..),
in the u->init function ,the command Read_local_version is written(using
different baudrates)...but after that when "select" is called the return
value is zero..indicating no response from the module...and then hciattach
fails...so does hciconfig(which shows no output)..Is that necessary to enter
the manufacturer mode and write the init command if I am using 115200??(in
simple words should I do anything in hciattach if I am using 115200?)

But when I call hciattach with "any' ....hciconfig reports the presence of
the device and /var/log/messages shows hci0 dev registered but I am not able
to do a hciconfig hci0 up...as it gives Can't init device connection timed
out...

Thnak you for your time...
Regards,
George.





On Feb 1, 2008 10:03 PM, Brad Midgley <bmidgley@gmail.com> wrote:

> George
>
> You should have a look at the gumstix patches to hciattach. In the
> current form they're too gross to merge upstream but they do reveal
> some hacks that are good to know on this adapter.
>
> http://docwiki.gumstix.org/Buildroot
>
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

------=_Part_7699_9924709.1202211534770
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Brad,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thanks for your quick reply.I had a quick look(as i dont have a lot of time to bring the 31308 up..:-(. at the gumstix site and had gone through the hciattach patches found there. now I have a patch which was used by a&nbsp; balckfin team on muClinux.(Almost same as the gumstix one..),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <br>
in the u-&gt;init function ,the command Read_local_version is written(using different baudrates)...but after that when &quot;select&quot; is called the return value is zero..indicating no response from the module...and then hciattach fails...so does hciconfig(which shows no output)..Is that necessary to enter the manufacturer mode and write the init command if I am using 115200??(in simple words should I do anything in hciattach if I am using 115200?)<br>
<br>But when I call hciattach with &quot;any&#39; ....hciconfig reports the presence of the device and /var/log/messages shows hci0 dev registered but I am not able to do a hciconfig hci0 up...as it gives Can&#39;t init device connection timed out...<br>
<br>Thnak you for your time...<br>Regards,<br>George.<br><br><br><br><br><br><div class="gmail_quote">On Feb 1, 2008 10:03 PM, Brad Midgley &lt;<a href="mailto:bmidgley@gmail.com">bmidgley@gmail.com</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
George<br><br>You should have a look at the gumstix patches to hciattach. In the<br>current form they&#39;re too gross to merge upstream but they do reveal<br>some hacks that are good to know on this adapter.<br><br><a href="http://docwiki.gumstix.org/Buildroot" target="_blank">http://docwiki.gumstix.org/Buildroot</a><br>
<br>Brad<br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by: Microsoft<br>Defy all challenges. Microsoft(R) Visual Studio 2008.<br><a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target="_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>
_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>
</blockquote></div><br>

------=_Part_7699_9924709.1202211534770--


--===============1730370334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1730370334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1730370334==--
