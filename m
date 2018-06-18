Return-Path: <bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 18 Jun 2018 22:37:31 +0530
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: johan.hedberg@gmail.com, marcel@holtmann.org, mka@chromium.org,
 thierry.escande@linaro.org, linux-bluetooth@vger.kernel.org,
 rtatiya@codeaurora.org, hemantg@codeaurora.org,
 linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 8/8] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990
In-Reply-To: <152934015159.16708.15821626950761504540@swboyd.mtv.corp.google.com>
References: <20180616062718.29844-1-bgodavar@codeaurora.org>
 <20180616062718.29844-9-bgodavar@codeaurora.org>
 <152934015159.16708.15821626950761504540@swboyd.mtv.corp.google.com>
Message-ID: <683e1475fa74c88614143456ad2cc85a@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stephen,

Please find my comments inline.

On 2018-06-18 22:12, Stephen Boyd wrote:
> Quoting Balakrishna Godavarthi (2018-06-15 23:27:18)
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 28ae6a17a595..1961e313aae7 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1031,9 +1145,118 @@ static struct hci_uart_proto qca_proto = {
>>         .dequeue        = qca_dequeue,
>>  };
>> 
>> +static const struct qca_vreg_data qca_cherokee_data = {
>> +       .soc_type = QCA_WCN3990,
>> +       .vregs = (struct qca_vreg []) {
>> +               { "vddio",   1352000, 1352000,  0 },
>> +               { "vddxtal", 1904000, 2040000,  0 },
>> +               { "vddcore", 1800000, 1800000,  1 },
>> +               { "vddpa",   1304000, 1304000,  1 },
>> +               { "vddldo",  3000000, 3312000,  1 },
> 
> Load of 0 and 1 seems sort of odd. Are these made up to indicate "some
> load" vs. "no load"?
> 

[Bala]: this value specifies the output load current required to turn on 
the wcn3990.
         in struct defined vddio\vddxtal are smps, with fixed load.
         regs from vddcore/vddpa/vddldo are programmable line regulators, 
in which we need to set the basic load.


>> +       },
>> +       .num_vregs = 5,
>> +};
>> +
>> +static int qca_enable_regulator(struct qca_vreg vregs,
>> +                               struct regulator *regulator)
>> +{
>> +       int ret;
>> +
>> +       ret = regulator_set_voltage(regulator, vregs.min_uV,
>> +                                   vregs.max_uV);
>> +       if (ret)
>> +               goto out;
> 
> Just return ret;

[Bala]: will update.

> 
>> +
>> +       if (vregs.load_uA)
>> +               ret = regulator_set_load(regulator,
>> +                                        vregs.load_uA);
>> +
>> +       if (ret)
>> +               goto out;
>> +
> 
> Same.
> 

[Bala]: will update.

>> +       ret = regulator_enable(regulator);
>> +
>> +out:
>> +       return ret;
> 
> And make this return regulator_enable(regulator).
> 

[Bala]: will update.

>> +
>> +}
>> +

Thanks for reviewing the patch.

-- 
Regards
Balakrishna.
