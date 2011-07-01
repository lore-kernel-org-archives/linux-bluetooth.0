Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110701090957.GA14945@aemeltch-MOBL1.ger.corp.intel.com>
References: <1309472456-24674-1-git-send-email-andre.guedes@openbossa.org>
	<1309472456-24674-3-git-send-email-andre.guedes@openbossa.org>
	<20110701090957.GA14945@aemeltch-MOBL1.ger.corp.intel.com>
Date: Fri, 1 Jul 2011 06:56:31 -0400
Message-ID: <BANLkTinRy=wJHPduQ0QUvKq7jtnvHhUycw@mail.gmail.com>
Subject: Re: [PATCH 3/5] Bluetooth: Add enable_le module parameter
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Jul 1, 2011 at 5:09 AM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
>> +static void hci_set_le_support(struct hci_dev *hdev)
>> +{
>> +     struct hci_cp_write_le_host_supported cp;
>> +
>> +     memset(&cp, 0, sizeof(cp));
>> +
>> +     if (enable_le) {
>> +             cp.le = 1;
>> +             cp.simul = !!(hdev->features[6] & LMP_SIMUL_LE_BR);
>
> Typo?

Usually this is a trick (used in other parts of the kernel) to assign
only 0 or 1 to a variable based on a value where non-zero means
"true". It is equivalent to:

if (hdev->features[6] & LMP_SIMUL_LE_BR)
    cp.simul = 1;
else
    cp.simul = 0;

(yes, I came across this same feeling when I saw this for the first
time on bluetooth kernel code)

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
