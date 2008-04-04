Return-Path: <cyrus@holtmann.org>
Message-ID: <5eee8c670804040158h470b6ec6g9a5eede5eb459a4d@mail.gmail.com>
Date: Fri, 4 Apr 2008 09:58:40 +0100
From: "Odysseus Flappington" <deriziotis@gmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [Bluez-users] hciconfig hci0 reset bug
Cc: "Dave Young" <hidave.darkstar@gmail.com>,
	"BlueZ users" <bluez-users@lists.sourceforge.net>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <9CBA2065-DBBE-4342-BF35-2C24BDF829C5@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5339_605194.1207299520135"
References: <5eee8c670802281451i392c0debq7a16286d76d33bfb@mail.gmail.com>
	 <a8e1da0803021721m3145bc7fpd896760d4bed7d97@mail.gmail.com>
	 <a8e1da0803021724h654f65ceif24b2035dc94a5ec@mail.gmail.com>
	 <5eee8c670803030335v49536053j136b8b46addb8129@mail.gmail.com>
	 <5eee8c670803031419k10c8e625p447f8f98ac27dcb9@mail.gmail.com>
	 <5eee8c670803170528o44384744pe238c378953dbc02@mail.gmail.com>
	 <a8e1da0803180014u262a7ee0h25ff58a0e6363dfd@mail.gmail.com>
	 <5eee8c670803201019q4703c779wbb597b806cf4d7c@mail.gmail.com>
	 <a8e1da0803211729l1fdfeeb5ie22c70652bc1e76a@mail.gmail.com>
	 <9CBA2065-DBBE-4342-BF35-2C24BDF829C5@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

------=_Part_5339_605194.1207299520135
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey Marcel,

On 26/03/2008, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Dave,
>
>  I've been looking around to see if I could figure out the build id where
> > > the
> > > dongles started shipping with the correct HCI_Reset. I think I may
> > > have
> > > found something.
> > >
> >
> > Thanks a lot.
> >
> > Marcel, I think it's what you want.  I would like to file a patch.
> >
>
> yes, but I already got it via CSR internals. They have always been helpful
> when it comes to BlueZ. CSR is an open source friendly company. I didn't
> have time to actually produce that patch since we have to turn the whole
> logic around.


Does this mean we have all the information needed to write the patch? Have
you got the logic for a solution ready, but just need time to get it
written?

If I understand correctly, we can't be sure that all non-L2CAP/RFCOMM dongles
with build id > 118 will need a reset since they possibly still released
older firmware on newer builds. If this is the case, it seems like the only
way to be sure of the build id is by testing as many dongles as possible.

I don't see how we can do this other than trying to buy as many older
bluetooth dongles as possible. I can't imagine any of us would be willing to
do this, so perhaps the best thing to do is to reset all build ids > 118 and
adjust the build id as people submit bug-reports related to this issue as
time goes on. Asking whoever submitted a bug report to report their build id
should be reasonable in order to make the fix more accurate.

I would really like to see this fix released since as a user my experience
with external bluetooth dongles in Linux was very disappointing due to this
bug.

Many thanks,
Alex Deriziotis (Jackflap)

------=_Part_5339_605194.1207299520135
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey Marcel,<br><br><div><span class="gmail_quote">On 26/03/2008, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Dave,<span class="q"><br>
<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
I&#39;ve been looking around to see if I could figure out the build id where the<br>
dongles started shipping with the correct HCI_Reset. I think I may have<br>
found something.<br>
</blockquote>
<br>
Thanks a lot.<br>
<br>
Marcel, I think it&#39;s what you want. &nbsp;I would like to file a patch.<br>
</blockquote>
<br></span>
yes, but I already got it via CSR internals. They have always been helpful when it comes to BlueZ. CSR is an open source friendly company. I didn&#39;t have time to actually produce that patch since we have to turn the whole logic around.</blockquote>
<div><br>Does this mean we have all the information needed to write the patch? Have you got the logic for a solution ready, but just need time to get it written?<br><br>If I understand correctly, we can&#39;t be sure that all non-<span class="q">L2CAP/RFCOMM </span>dongles with build id &gt; 118 will need a reset since they possibly still released older firmware on newer builds. If this is the case, it seems like the only way to be sure of the build id is by testing as many dongles as possible.<br>
<br>I don&#39;t see how we can do this other than trying to buy as many older bluetooth dongles as possible. I can&#39;t imagine any of us would be willing to do this, so perhaps the best thing to do is to reset all build ids &gt; 118 and adjust the build id as people submit bug-reports related to this issue as time goes on. Asking whoever submitted a bug report to report their build id should be reasonable in order to make the fix more accurate.<br>
<br>I would really like to see this fix released since as a user my
experience with external bluetooth dongles in Linux was very
disappointing due to this bug.<br>
<br>Many thanks,<br>Alex Deriziotis (Jackflap)<br><br><br><br><br><br><br><br></div><br></div>

------=_Part_5339_605194.1207299520135--
