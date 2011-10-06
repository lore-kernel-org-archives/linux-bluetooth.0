Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CA+i+Aw3YGAfFJJoXftWV7a=PW7FYkFGLA0pZPZsMhhDgebJJrQ@mail.gmail.com>
References: <1317825160-21429-1-git-send-email-lkslawek@gmail.com>
	<1317825160-21429-4-git-send-email-lkslawek@gmail.com>
	<CABBYNZJyPMny8MfqxDsJ256Q+Ft-1+DFwfWbi12MxNz1rEJ8cw@mail.gmail.com>
	<CA+i+Aw3=DUoVs68xQwHcZG_OBh0eYOG3q2xhYcvc_8J+wciAnA@mail.gmail.com>
	<CA+i+Aw1wCnxAfij3c0dQCVsDXhBHCrwWoyJhv6=Ctdn=T7kfXQ@mail.gmail.com>
	<CABBYNZJOosjm-Uok+p9+smd0ek=0Hc3LG43x1y3A9qQhWp5Egg@mail.gmail.com>
	<20111006094430.20945f35guft5q4g@mail.hendrik-sattler.de>
	<CABBYNZLBi_3sAohSShnHTfayd=g0VqZ2CYJC=5qfHBQiHcQsSg@mail.gmail.com>
	<CA+i+Aw3YGAfFJJoXftWV7a=PW7FYkFGLA0pZPZsMhhDgebJJrQ@mail.gmail.com>
Date: Thu, 6 Oct 2011 12:17:05 +0300
Message-ID: <CABBYNZK2kXdaSRcmZGNchu90WzXsvmotXaFD7N_2vPLAT4AjeA@mail.gmail.com>
Subject: Re: [PATCH obexd 4/4] Simplify code for calling mime driver flush()
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: Hendrik Sattler <post@hendrik-sattler.de>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawomir,

On Thu, Oct 6, 2011 at 11:21 AM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
>
> obexd works as it should. The code is coping with this by doing a
> buffering on behalf of a service driver if the service driver is not
> using chkput. So from the service perspective it will be still put,
> open, write, as the actual writing to mime driver is started at
> obex_put_stream_start.

Except that we should not buffer more than MTU size, also this is
completely the opposite of what we should be doing which is to copy
buffers as little as possible. As for broken I mean the design is
broken since if the service does not implement .put obexd should
return not implemented right in the first packet, actually .put is
completely useless right now since it is basically as calling a .flush
but it does useless checks.

-- 
Luiz Augusto von Dentz
