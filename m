Return-Path: <loic.poulain@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1E4DE3D9-A8A7-4789-B6F1-C2CA4ED26EA8@holtmann.org>
References: <1524728332-10093-1-git-send-email-loic.poulain@linaro.org>
 <1524728332-10093-2-git-send-email-loic.poulain@linaro.org> <1E4DE3D9-A8A7-4789-B6F1-C2CA4ED26EA8@holtmann.org>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Thu, 26 Apr 2018 13:10:32 +0200
Message-ID: <CAMZdPi8U864mrGwP5ShKEeYoztPn0ahLKgTfPPgrLNFyix-tkQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: btqca: Add AR3002 rampatch support
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

>> +     if (mode == ROME_SKIP_EVT_VSE_CC || mode == ROME_SKIP_EVT_VSE) {
>> +             return __hci_cmd_send(hdev, EDL_PATCH_CMD_OPCODE, seg_size + 2,
>> +                                   cmd);
>> +     }
>> +
>
> any reason for these { } ?

My bad, missed your previous comment.
