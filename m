Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110411173409.1567679c@lxorguk.ukuu.org.uk>
References: <yun1v1fj024.fsf@aiko.keithp.com>
	<alpine.LFD.2.00.1104070022280.3971@localhost6.localdomain6>
	<alpine.LFD.2.00.1104082340020.2724@localhost6.localdomain6>
	<yunaag0tjzb.fsf@aiko.keithp.com>
	<20110409000857.GB25581@piper>
	<20110411173409.1567679c@lxorguk.ukuu.org.uk>
Date: Mon, 11 Apr 2011 13:59:23 -0300
Message-ID: <BANLkTinK-cA67X6Knp-h5SKpjpDpwaMgZg@mail.gmail.com>
Subject: Re: 2.6.39-rc2 regression: X201s fails to resume b77dcf8460ae57d4eb9fd3633eb4f97b8fb20716
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Keith Packard <keithp@keithp.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Mon, Apr 11, 2011 at 1:34 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> I took a shot at it and just sent a patch (also attached for convenience)
>> that should solve the problem.
>
> Well its reverting too much but its also looking pretty bogus to me
>
> -       /* Stop timer, it might be running */
> -       del_timer_sync(&hdev->cmd_timer);
> -
>        if (!test_and_clear_bit(HCI_UP, &hdev->flags)) {
>                hci_req_unlock(hdev);
>                return 0;
>
> So you've now got a path where you leave the timer running and didn't
> before - not it appears one that is a good idea.
>
> Certainly not the kind of change that should be considered for a
> regression fix for an rc kernel. It's far too big a behavioural change to
> be safe.

Considering what was said and that this patch didn't hit your public tree yet,
I guess that this patch should be ignored.

Will send a proper fix soon. Thanks all.

>
> Alan
>


Cheers,
-- 
Vinicius
