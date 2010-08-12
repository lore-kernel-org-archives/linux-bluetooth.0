Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Aug 2010 16:57:03 +0200
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Marcel J.E. Mol" <marcel@mesa.nl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] IrMC sync server support
Message-ID: <20100812145703.GD7345@joshua.mesa.nl>
References: <201008121013.o7CADR8r004125@joshua.mesa.nl> <AANLkTikoUKpDtT5CU7hP+QZBkbc9-p_YymXGPUbJVB+s@mail.gmail.com> <20100812121212.GA16738@joshua.mesa.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset*=utf-8''%E2%80%9Cus-ascii
In-Reply-To: <20100812121212.GA16738@joshua.mesa.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Aug 12, 2010 at 3:12 PM, Marcel J.E. Mol <marcel@mesa.nl> wrote:
> abstracting it made de irmc_open() more clean (e.g. no buffer fills in
> irmc_open()) and more readable in my opinion.
> The specs for devinfo.txt contain many more attributes but the currrent
> set seems to be enough. In future this may need to be extended and
> supporting scripts may be needed for getting the info. The current
> values are actually not correct I think as the will be the same for any
> device now... (hence the hint for using x-obex/capabilities in
> irmc_connect().)

It doesn't look like we can use x-obex/capabilities for this
devinfo.txt, afaik they are not the same thing, thats why I suggested
open it as any regular file so the platforms has some way to customize
it. Executing scripts is always tricky since you have to depend on
async io to suspend the request while the script is running and resume
when finished. Of course if there is no file called devinfo.txt then
we can think about a default value, what does the spec says in this
regard, is devinfo.txt mandatory? If not then we can just fail as we
do for x-obex/capabilities when not set.

-- 
Luiz Augusto von Dentz
Computer Engineer
