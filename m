Return-Path: <cyrus@holtmann.org>
Message-ID: <4EFBB2A9.5040804@gmail.com>
Date: Thu, 29 Dec 2011 01:22:01 +0100
From: Rene Herman <rene.herman@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Gustavo Padovan <padovan@profusion.mobi>,
 Andre Guedes <andre.guedes@openbossa.org>,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [bluetooth] linux-3.x regression (bisected)
References: <4EF3BACA.1080405@gmail.com> <CACJA=fVezGGcgAtbzG=+ouWq0PiHbgXN1YPwL+VDUphWS7wnrw@mail.gmail.com> <4EFA1EB8.9090005@gmail.com> <20111227203008.GA13870@joana> <4EFA447C.3030906@gmail.com> <20111228012248.GC13870@joana> <20111228012850.GD13870@joana> <4EFA7696.6060506@gmail.com> <20111228155225.GA23292@joana> <1325090923.1965.282.camel@aeonflux> <4EFB957A.5070606@gmail.com> <1325113623.1965.289.camel@aeonflux>
In-Reply-To: <1325113623.1965.289.camel@aeonflux>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 29-12-11 00:07, Marcel Holtmann wrote:

>> By the way, while the bluetooth (2.0) spec seems to consist of a 1230
>> page document that I am most certainly not going to study ...
>>
>> ... I couldn't help noticing that the HCI_Read_Local_Extended_Features
>> command is in fact specified to return "The highest features page number
>> which contains non-zero bits for the local device", and if I look at the
>> above, it seems to indeed return max=0.
>>
>> Is it as such not in fact the case that the dongle is spec-compliant,
>> whereas it's the linux code that neglects to check that return value in
>> order to make sure that it requested a valid page?
>
> the Linux code indeed is broken for not checking the returned page, but
> it is broken for different reasons.
>
> However the expected result from the dongle would be an error code and
> not just returning page 0 instead.

Okay. Just as an additional data point:

I came across the HCI_Read_Local_Supported_Commands command in the spec 
a few pages up and quickly verified that the adapter doesn't in fact 
deny support for the HCI_Read_Local_Extended_Features command.

That is, after applying the below, I do get:

hci_cc_read_local_commands:hci0 status 0x0
hci_cc_read_local_commands:hci0 commands[14] 0xe8

which does claim support for the command (bit 6 of commands[14]).

Thought I'd check since if it hadn't, that would imply a certain fix but 
that can't be used then.

I'll stand by to test whatever final solution is arrived at.

(although I don't personally care, linux 3.0.y and 3.1.y may want it as 
well at that point I guess).

Rene.

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8fe270c..0ac87ea 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -622,6 +622,7 @@ static void hci_cc_read_local_commands(struct 
hci_dev *hdev, struct sk_buff *skb
                 goto done;

         memcpy(hdev->commands, rp->commands, sizeof(hdev->commands));
+       BT_DBG("%s commands[14] 0x%x", hdev->name, rp->commands[14]);

         if (test_bit(HCI_INIT, &hdev->flags) && (hdev->commands[5] & 0x10))
                 hci_setup_link_policy(hdev);
