Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Aug 2010 17:39:35 +0200
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] IrMC sync server support
Message-ID: <20100812153935.GE7345@joshua.mesa.nl>
References: <201008121013.o7CADR8r004125@joshua.mesa.nl> <AANLkTikoUKpDtT5CU7hP+QZBkbc9-p_YymXGPUbJVB+s@mail.gmail.com> <20100812121212.GA16738@joshua.mesa.nl> <20100812145703.GD7345@joshua.mesa.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset*=utf-8''%E2%80%9Cus-ascii
In-Reply-To: <20100812145703.GD7345@joshua.mesa.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Aug 12, 2010 at 04:57:03PM +0200, Luiz Augusto von Dentz wrote:
> Hi Marcel,
> 
> On Thu, Aug 12, 2010 at 3:12 PM, Marcel J.E. Mol <marcel@mesa.nl> wrote:
> > abstracting it made de irmc_open() more clean (e.g. no buffer fills in
> > irmc_open()) and more readable in my opinion.
> > The specs for devinfo.txt contain many more attributes but the currrent
> > set seems to be enough. In future this may need to be extended and
> > supporting scripts may be needed for getting the info. The current
> > values are actually not correct I think as the will be the same for any
> > device now... (hence the hint for using x-obex/capabilities in
> > irmc_connect().)
> 
> It doesn't look like we can use x-obex/capabilities for this
> devinfo.txt, afaik they are not the same thing, thats why I suggested
> open it as any regular file so the platforms has some way to customize
> it. Executing scripts is always tricky since you have to depend on
> async io to suspend the request while the script is running and resume
> when finished. Of course if there is no file called devinfo.txt then
> we can think about a default value, what does the spec says in this
> regard, is devinfo.txt mandatory? If not then we can just fail as we
> do for x-obex/capabilities when not set.

I don;t know how diffenent capbilities is from the things devinfo.txt
needs. On the n900 the capabilities script seems to provide what is needed
for devinfo.txt so I was lead by that...

I'm not suere how mandatory devinfo.txt is. My carkit did ask for it but
when I returned some data to it it never asked again... It probably will 
when I remove my phones configuration from the carkit.

I never checked the specs again for it as it all seems to work fine with
the code as it is now. It also works for other n900 owners so i did not
bother any more.

I think the code seems to be in a reasonable state to be usefull now so
that is why I released it here. There is probably lots of extra work to be
done to be fully specs complient. But by releasing it other people can jump 
in and improve...

Thanks,

-Marcel
-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com
