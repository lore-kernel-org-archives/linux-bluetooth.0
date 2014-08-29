Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <0032498A-436E-4A05-ABD0-BF02AC15F7B6@holtmann.org>
References: <1409264113-12239-1-git-send-email-armansito@chromium.org>
	<1409264113-12239-3-git-send-email-armansito@chromium.org>
	<0032498A-436E-4A05-ABD0-BF02AC15F7B6@holtmann.org>
Date: Fri, 29 Aug 2014 08:35:46 -0700
Message-ID: <CAHrH25S6Y7EuWX4fTcoKEtTgrTbjLNLWv6t6YTe-J9fCP2VqSg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/7] tools/btgatt-client: Added L2CAP LE ATT connection.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>> +static int l2cap_set_lm(int sock, int level)
>> +{
>> +     int lm_map[] = {
>> +             0,
>> +             L2CAP_LM_AUTH,
>> +             L2CAP_LM_AUTH | L2CAP_LM_ENCRYPT,
>> +             L2CAP_LM_AUTH | L2CAP_LM_ENCRYPT | L2CAP_LM_SECURE,
>> +     }, opt = lm_map[level];
>> +
>> +     if (setsockopt(sock, SOL_L2CAP, L2CAP_LM, &opt, sizeof(opt)) < 0)
>> +             return -errno;
>> +
>> +     return 0;
>> +}
>
> can we please use BT_SECURITY option instead of the link mode. You have dug out something from 13 years ago now. I do not think that we have a kernel with LE support that does not support BT_SECURITY. So such a fallback will never be triggered.
>

Yeah, I didn't really know what I was doing; I pretty much just copied
it from btio.

>> +     /* Set up source address */
>> +     memset(&srcaddr, 0, sizeof(srcaddr));
>> +     srcaddr.l2_family = AF_BLUETOOTH;
>> +     srcaddr.l2_cid = htobs(ATT_CID);
>> +     srcaddr.l2_bdaddr_type = BDADDR_LE_PUBLIC;
>
> This one is dangerous if you end up with a LE only controller that does not have a public address.
>
>> +     bacpy(&srcaddr.l2_bdaddr, src);
>
> I wonder if specifying BDADDR_ANY and bdaddr_type == 0 does the right thing here. There is one hole that we punched into the kernel checks for bind.
>

Passing 0 for bdaddr_type seems to work fine. I already pass
BDADDR_ANY in the main function if no -i flag is given.

Just sent the updated patch set.

Thanks,
Arman
