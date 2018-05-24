Return-Path: <tobi@biertrinken.rocks>
Subject: Re: warmreset breaks communication with CSR8811
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
References: <c20e33c4-ff97-00de-9fb2-e70b0d3b983a@biertrinken.rocks>
 <09F3DFD3-62AE-4DB8-BAC0-E124F55908E6@holtmann.org>
From: tobi <tobi@biertrinken.rocks>
Message-ID: <31e13b79-4dfe-6db9-e003-5a557542210f@biertrinken.rocks>
Date: Thu, 24 May 2018 12:48:42 +0200
MIME-Version: 1.0
In-Reply-To: <09F3DFD3-62AE-4DB8-BAC0-E124F55908E6@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

yes - i have tried commands like
bccmd -t BCSP -d /dev/ttyS1 psload 8811.psr
before hciattach and it fails the same way.
(most commands work fine until i do a psload -r or warmreset command)

Is there any way to reinitialize an attached hci device or something 
like "hcidetach"?

best regards,

Tobi



On 05/22/2018 05:19 PM, Marcel Holtmann wrote:
> Hi Tobi,
>
>> i have problem connecting bluez (currently im using 5.49 from debian:unstable and linux-4.14) to my CSR8811 (connected via 2 wire UART).
>> hciattach works and i can use some bccmd commands but when i do a warmreset (to activate my pskey changes) bluez seems unable to get a valid
>> reply from the chip :-(
>>
>> here my commands:
>>
>> root@BLOKS ~# hciattach -s 38400 /dev/ttyS1 bcsp 38400 noflow
>> Device setup complete
>> root@BLOKS ~# hciconfig
>> hci0:    Type: Primary  Bus: UART
>>      BD Address: 00:02:5B:00:A5:A5  ACL MTU: 310:10  SCO MTU: 64:8
>>      UP RUNNING
>>      RX bytes:1314 acl:0 sco:0 events:41 errors:0
>>      TX bytes:2583 acl:0 sco:0 commands:40 errors:0
>>
>> root@BLOKS ~# bccmd -t HCI buildname
>> Build name: gem_5hci_rom_bt4.1_gemA12_1407301204_dspm_encr128 2014-07-30
>> root@BLOKS ~# bccmd -t HCI psload -s 0 /data/8811.psr
>> Loading PSKEY_BDADDR ... done
>> Loading PSKEY_ANA_FREQ ... done
>> root@BLOKS ~# bccmd -t HCI warmreset
>> root@BLOKS ~# hciconfig
>> hci0:    Type: Primary  Bus: UART
>>      BD Address: 00:02:5B:00:A5:A5  ACL MTU: 310:10  SCO MTU: 64:8
>>      UP RUNNING
>>      RX bytes:1639 acl:0 sco:0 events:47 errors:0
>>      TX bytes:3587 acl:0 sco:0 commands:76 errors:0
>>
>> root@BLOKS ~# bccmd -t HCI buildname
>> Can't read version info for hci0: Connection timed out (110)
>> root@BLOKS ~# bccmd -t HCI psload -s 0 /data/8811.psr
>> Can't read version info for hci0: Connection timed out (110)
>> root@BLOKS ~#
> I am not surprised this fails since hciattach and BCSP is not really working well when you have to restart the controller. Have you tried to use the bcsp transport of bccmd tool? And only when that finished run hciattach.
>
> Otherwise the BCSP support really needs to be convert into something that would work with btattach. I have not seen many using BCSP these days. Most switched to 3-Wire UART instead.
>
> Regards
>
> Marcel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
