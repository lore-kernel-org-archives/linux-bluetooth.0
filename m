Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1429697.uq0A3eL4HE@athlon>
References: <1560638.biMD7yTzvv@athlon>
	<20130625184848.GA29741@x220.P-661HNU-F1>
	<1429697.uq0A3eL4HE@athlon>
Date: Tue, 25 Jun 2013 16:21:34 -0400
Message-ID: <CAJdJm_NtNXFbMPBdzxb_Tmj4M76AxpB5CbdYakk94XUy+KMHiQ@mail.gmail.com>
Subject: Re: regression in sdp lib
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Jun 25, 2013 at 3:54 PM, Szymon Janc <szymon.janc@gmail.com> wrote:
> Hi Johan,
>
> On Tuesday 25 June 2013 21:48:48 Johan Hedberg wrote:
>> Hi Szymon,
>>
>> On Fri, Jun 21, 2013, Szymon Janc wrote:
>> > commit 'lib: Add range check for SDP_SVC_ATTR_RSP/SDP_SVC_SEARCH_ATTR_RSP'
>> > 1796f00e846561af broke sdp with Nokia BH217 headset.
>>
>> Since there evidently wasn't any progress on this issue and we want to
>> get a new release out (due to also another severe regression) I've gone
>> ahead and simply reverted the original patch. Nevertheless, I'm still
>> looking forward to seeing a proper fix for this issue.
>
> Maybe it would be enough to verify size only if there is no continuation?
>
>                 /* Valid range for rsp_count is 0x0002-0xFFFF */
> -               if (rsp_count < 0x0002) {
> +               if (t->rsp_concat_buf.data_size == 0 && rsp_count < 0x0002) {
>                         t->err = EPROTO;
>
>
> Seems to be working for me but I'm that much familiar sdp code..

I agree this change should work just fine (to my understanding). If
rsp_count is invalid , it will fail with EPROTO and BlueZ will not
issue a continuation SDP request anyway.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
