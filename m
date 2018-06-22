Return-Path: <bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 22 Jun 2018 20:55:11 +0530
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: johan.hedberg@gmail.com, marcel@holtmann.org, mka@chromium.org,
 thierry.escande@linaro.org, linux-bluetooth@vger.kernel.org,
 rtatiya@codeaurora.org, hemantg@codeaurora.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 8/8] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990
In-Reply-To: <152963092979.16708.15747731441619460587@swboyd.mtv.corp.google.com>
References: <20180616062718.29844-1-bgodavar@codeaurora.org>
 <20180616062718.29844-9-bgodavar@codeaurora.org>
 <152934015159.16708.15821626950761504540@swboyd.mtv.corp.google.com>
 <683e1475fa74c88614143456ad2cc85a@codeaurora.org>
 <152963092979.16708.15747731441619460587@swboyd.mtv.corp.google.com>
Message-ID: <7cd4f2000a11176152bf004b18fe37b6@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stephen,

On 2018-06-22 06:58, Stephen Boyd wrote:
> Quoting Balakrishna Godavarthi (2018-06-18 10:07:31)
>> Hi Stephen,
>> 
>> Please find my comments inline.
>> 
>> On 2018-06-18 22:12, Stephen Boyd wrote:
>> > Quoting Balakrishna Godavarthi (2018-06-15 23:27:18)
>> >> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> >> index 28ae6a17a595..1961e313aae7 100644
>> >> --- a/drivers/bluetooth/hci_qca.c
>> >> +++ b/drivers/bluetooth/hci_qca.c
>> >> @@ -1031,9 +1145,118 @@ static struct hci_uart_proto qca_proto = {
>> >>         .dequeue        = qca_dequeue,
>> >>  };
>> >>
>> >> +static const struct qca_vreg_data qca_cherokee_data = {
>> >> +       .soc_type = QCA_WCN3990,
>> >> +       .vregs = (struct qca_vreg []) {
>> >> +               { "vddio",   1352000, 1352000,  0 },
>> >> +               { "vddxtal", 1904000, 2040000,  0 },
>> >> +               { "vddcore", 1800000, 1800000,  1 },
>> >> +               { "vddpa",   1304000, 1304000,  1 },
>> >> +               { "vddldo",  3000000, 3312000,  1 },
>> >
>> > Load of 0 and 1 seems sort of odd. Are these made up to indicate "some
>> > load" vs. "no load"?
>> >
>> 
>> [Bala]: this value specifies the output load current required to turn 
>> on
>> the wcn3990.
>>          in struct defined vddio\vddxtal are smps, with fixed load.
>>          regs from vddcore/vddpa/vddldo are programmable line 
>> regulators,
>> in which we need to set the basic load.
> 
> I got that part, but a load of 1 still seems like a nonsensical value.
> Is it to workaround some issue with the regulator driver?
> 

[Bala]: i don't think, it is issue with regulator driver.

> It's also pretty weird to be setting regulator voltages here in the
> driver. Typically that's configured on the board and then the DT has 
> the
> right voltage already. The only case when the voltage may need to be 
> set
> by the driver is if the hardware can dynamically scale the voltage for
> things like DVFS. It looks like here that the voltage is always fixed,
> so probably we don't need to have any sort of voltage setting in this
> driver and can rely on the DTS file to get things right.


[Bala]: voltage required by wcn3990 are fixed. now i am using a 
programmable line regulators.
         in future, if i have an platform where we have a variable 
voltage regulators used.  i.e. an voltage can be scaled to the required 
voltage to wcn3990.
         in that case, we explicitly restrict the regulator output 
voltage to wcn3990 standards.

         let us take an example. i am using an programmable regulator, 
with varying output voltage ranges from 1v to 5v.
         but from wcn3990 we require an voltage 3.3v. while enabling the 
regulators.. so that output of regulator will be 3.3v fixed.

        one more case, every time when we have platform change.. we need 
to ensure that regulators voltage level should be matching with wcn3990.
        instead we expect platform vendor to do all these. i want to 
restrict the voltages in driver itself.

        please let me know, if cleared your query.


-- 
Regards
Balakrishna.
