Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZK2kXdaSRcmZGNchu90WzXsvmotXaFD7N_2vPLAT4AjeA@mail.gmail.com>
References: <1317825160-21429-1-git-send-email-lkslawek@gmail.com>
	<1317825160-21429-4-git-send-email-lkslawek@gmail.com>
	<CABBYNZJyPMny8MfqxDsJ256Q+Ft-1+DFwfWbi12MxNz1rEJ8cw@mail.gmail.com>
	<CA+i+Aw3=DUoVs68xQwHcZG_OBh0eYOG3q2xhYcvc_8J+wciAnA@mail.gmail.com>
	<CA+i+Aw1wCnxAfij3c0dQCVsDXhBHCrwWoyJhv6=Ctdn=T7kfXQ@mail.gmail.com>
	<CABBYNZJOosjm-Uok+p9+smd0ek=0Hc3LG43x1y3A9qQhWp5Egg@mail.gmail.com>
	<20111006094430.20945f35guft5q4g@mail.hendrik-sattler.de>
	<CABBYNZLBi_3sAohSShnHTfayd=g0VqZ2CYJC=5qfHBQiHcQsSg@mail.gmail.com>
	<CA+i+Aw3YGAfFJJoXftWV7a=PW7FYkFGLA0pZPZsMhhDgebJJrQ@mail.gmail.com>
	<CABBYNZK2kXdaSRcmZGNchu90WzXsvmotXaFD7N_2vPLAT4AjeA@mail.gmail.com>
Date: Thu, 6 Oct 2011 14:07:38 +0200
Message-ID: <CA+i+Aw2tH0tyUnprzjVYE9dJsDZHun2MMqNny8kc5KmYoe0FtA@mail.gmail.com>
Subject: Re: [PATCH obexd 4/4] Simplify code for calling mime driver flush()
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Hendrik Sattler <post@hendrik-sattler.de>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Oct 6, 2011 at 11:17 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Slawomir,
>
> On Thu, Oct 6, 2011 at 11:21 AM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
>>
>> obexd works as it should. The code is coping with this by doing a
>> buffering on behalf of a service driver if the service driver is not
>> using chkput. So from the service perspective it will be still put,
>> open, write, as the actual writing to mime driver is started at
>> obex_put_stream_start.
>
> Except that we should not buffer more than MTU size, also this is
> completely the opposite of what we should be doing which is to copy
> buffers as little as possible. As for broken I mean the design is
> broken since if the service does not implement .put obexd should
> return not implemented right in the first packet, actually .put is
> completely useless right now since it is basically as calling a .flush
> but it does useless checks.

>From my point of view as a person external to the project, developing
the new service driver, I assumed that the policy that allows making
drivers with both .chkput/.put and .put only has been provided on some
purpose. Even if this purpose doesn't seem to give any gain (well,
except maybe when one would like to access full buffered request from
a single write) and can lead to OOM in case of a service that doesn't
do obex_put_stream_start right in .chkput. Thus I didn't think of .put
as something useless.

If no, then the problem is not in the OpenOBEX itself, but in the way
it is used in obexd. OBEX_EV_REQCHECK is the event that is to be
delivered after the first packet. As Hendrik mentioned, it can be
omitted if there was only one packet, but obexd deals with it -
check_put() is also called from cmd_put() (called on OBEX_EV_REQ),
when the request haven't been yet "checked".

This could be done better by getting rid of .chkput and calling .put
on OBEX_EV_REQCHECK (or EV_REQ if no previous EV_REQCHECK) and .flush
always on EV_REQ.

And you are right that unfortunately checking for .put existence is
done too late, so the request will be fully received before responding
with "not implemented". Otherwise things are quite functional.

But well, now with the obexd going to be rewritten to use gobex, I
suppose these things do not matter any longer.

-- 
Slawomir Bochenski
