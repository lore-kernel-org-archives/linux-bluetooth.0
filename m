Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150219112608.GA7616@t440s.lan>
References: <1423848389-30900-1-git-send-email-jpawlowski@google.com>
	<20150219112608.GA7616@t440s.lan>
Date: Thu, 19 Feb 2015 08:58:30 -0800
Message-ID: <CAD0=r8yzqCdCtfXP5pP72UhU=BEE83=90PsvHSG=9o_1DU-74Q@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: fix service discovery behaviour for empty
 uuids filter
From: Jakub Pawlowski <jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Feb 19, 2015 at 3:26 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Jakub,
>
> On Fri, Feb 13, 2015, Jakub Pawlowski wrote:
>> @@ -4081,6 +4080,7 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
>>        */
>>       hci_discovery_filter_clear(hdev);
>>
>> +     hdev->discovery.service_scan = true;
>
> How much have you actually tested this patch considering that it doesn't even
> compile? The above should be 'service_discovery' rather than 'service_scan'.

I'm working on 3.14 chromeos branch with lots of backports, then I
have another machine with ubuntu with 3.19 where I test again, and
then I apply my patches to bluetooth-next when it works on both, but
sometimes some half-done version gets copied and emailed by mistake,
sorry. I'm uploading fixed version.

>
> I think there's also some mismatch of {} somewhere since I also get the
> following compile errors:
>
> net/bluetooth/mgmt.c: In function ‘mgmt_device_found’:
> net/bluetooth/mgmt.c:7391:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>  void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>  ^
> net/bluetooth/mgmt.c:7427:13: error: invalid storage class for function ‘adv_enable_complete’
>  static void adv_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
>              ^
> net/bluetooth/mgmt.c:7442:1: error: expected declaration or statement at end of input
>  }
>  ^
> net/bluetooth/mgmt.c:7442:1: error: expected declaration or statement at end of input
> net/bluetooth/mgmt.c:7283:7: warning: unused variable ‘match’ [-Wunused-variable]
>   bool match;
>        ^
>
> Johan
