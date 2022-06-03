Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184AEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jun 2022 14:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245138AbiFCOlB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jun 2022 10:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245123AbiFCOlA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jun 2022 10:41:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA8550464
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jun 2022 07:40:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: fdanis)
        with ESMTPSA id 4F4E61F4596C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654267258;
        bh=T/r0QPR6UcSHxHQ4G1IiVFBw1Kug/SbySFkXgtQd8/0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TiHtv5KWxUo+21QFEqS6u9Qq2F/Df/thakiBNM3pvglCdvLJnRVryRIKibiw4T0KL
         FC/dgaFhgBfwxP2YJrwKYF/pgdaKBK2v2Djx3i7kQplEOvVNMjaY/iKC/zsWO7+09A
         DWxp5GG6tymFIbBjpJNulZTquVYzVKdlXNbpuvUejlP8cb3/qxks/3ZI5ARWsv+UeI
         bkTooEqpGZUa8Sbx/jFerGtOHQ+lKSms3u6cnHdRgaVjOGR5jrN+zX4/y+gAFHTaiO
         PsWWgfDSSxvqWubTA0uRBFtn2F496KuPXo8u6RQTZq8ZtEeDsyGuiizMOyQbXNAreR
         0LwoO99HZw6NA==
Message-ID: <efd9d94d-59f4-6701-9a4d-028e9b0a8734@collabora.com>
Date:   Fri, 3 Jun 2022 16:40:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] btproxy: Allow to select multiple BT controllers
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20220602152613.79718-1-frederic.danis@collabora.com>
 <CABBYNZJuhnwOpzU_fjuo648O-9-gH+HU0vbH-ueQXU=z1gSYSQ@mail.gmail.com>
From:   =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <CABBYNZJuhnwOpzU_fjuo648O-9-gH+HU0vbH-ueQXU=z1gSYSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 02/06/2022 22:45, Luiz Augusto von Dentz wrote:
> Hi Frédéric,
>
> On Thu, Jun 2, 2022 at 9:08 AM Frédéric Danis
> <frederic.danis@collabora.com> wrote:
>> When running on a computer with a real Bluetooth controller (e.g. hci0) and
>> multiple emulators (e.g. hci1 and hci2) it isn't possible to use the
>> emulators with 2 test-runner vms.
>> If btproxy is started without index parameter the first test-runner will
>> use hci0, and btprox can't be started with multiple index parameters
>> (e.g. -i1 -i2).
>>
>> This patch allows to select the controllers to be used by btproxy.
> Does it keep the old behavior and adds the possibility to enter -i
> command line option multiple times?

Yes, it keeps old behavior when used without -i option, in this case it 
will try to use the first controller available.
The only change from the old behavior is that when started with one or 
more -i option it will not check if a client is already active, so no 
"Active client already present" error message.

>> ---
>>   tools/btproxy.c | 48 ++++++++++++++++++++++++++++++++++--------------
>>   1 file changed, 34 insertions(+), 14 deletions(-)
>>
>> diff --git a/tools/btproxy.c b/tools/btproxy.c
>> index 94ca1c7fd..c09a504ff 100644
>> --- a/tools/btproxy.c
>> +++ b/tools/btproxy.c
>> @@ -48,6 +48,7 @@ struct sockaddr_hci {
>>   };
>>   #define HCI_CHANNEL_USER       1
>>   #define HCI_INDEX_NONE         0xffff
>> +#define HCI_INDEX_MAX          15
>>
>>   static uint16_t hci_index = HCI_INDEX_NONE;
>>   static bool client_active = false;
>> @@ -533,13 +534,28 @@ static bool setup_proxy(int host_fd, bool host_shutdown,
>>          return true;
>>   }
>>
>> -static int open_channel(uint16_t index)
>> +static int get_next_hci_index(int index)
>> +{
>> +       while (++index <= HCI_INDEX_MAX) {
>> +               if (hci_index & (1 << index))
>> +                       return index;
>> +       }
>> +
>> +       return -1;
>> +}
> Perhaps use util_get_uid?

Yes, this should simplify it

>> +
>> +static int open_channel(int index)
>>   {
>>          struct sockaddr_hci addr;
>>          int fd, err;
>>
>> -       if (index == HCI_INDEX_NONE)
>> -               index = 0;
>> +       if (index == HCI_INDEX_NONE) {
>> +               index = get_next_hci_index(-1);
>> +               if (index < 0) {
>> +                       perror("No controller available");
>> +                       return -1;
>> +               }
>> +       }
>>
>>          printf("Opening user channel for hci%u\n", index);
>>
>> @@ -561,9 +577,10 @@ static int open_channel(uint16_t index)
>>                  /* Open next available controller if no specific index was
>>                   * provided and the error indicates that the controller.
>>                   */
>> -               if (hci_index == HCI_INDEX_NONE &&
>> +               index = get_next_hci_index(index);
>> +               if (index >=0 &&
>>                                  (err == -EBUSY || err == -EUSERS))
>> -                       return open_channel(++index);
>> +                       return open_channel(index);
>>
>>                  perror("Failed to bind Bluetooth socket");
>>                  return -1;
>> @@ -601,13 +618,7 @@ static void server_callback(int fd, uint32_t events, void *user_data)
>>                  return;
>>          }
>>
>> -       if (client_active && hci_index != HCI_INDEX_NONE) {
>> -               fprintf(stderr, "Active client already present\n");
>> -               close(host_fd);
>> -               return;
>> -       }
>> -
>> -       dev_fd = open_channel(hci_index);
>> +       dev_fd = open_channel(HCI_INDEX_NONE);
>>          if (dev_fd < 0) {
>>                  close(host_fd);
>>                  return;
>> @@ -800,6 +811,7 @@ int main(int argc, char *argv[])
>>
>>          for (;;) {
>>                  int opt;
>> +               int index;
>>
>>                  opt = getopt_long(argc, argv, "rc:l::u::p:i:aezdvh",
>>                                                  main_options, NULL);
>> @@ -844,7 +856,15 @@ int main(int argc, char *argv[])
>>                                  usage();
>>                                  return EXIT_FAILURE;
>>                          }
>> -                       hci_index = atoi(str);
>> +                       index = atoi(str);
>> +                       if (index > HCI_INDEX_MAX) {
>> +                               fprintf(stderr, "Invalid controller index\n");
>> +                               usage();
>> +                               return EXIT_FAILURE;
>> +                       }
>> +                       if (hci_index == HCI_INDEX_NONE)
>> +                               hci_index = 0;
>> +                       hci_index |= 1 << index;
>>                          break;
>>                  case 'a':
>>                          type = HCI_AMP;
>> @@ -892,7 +912,7 @@ int main(int argc, char *argv[])
>>                  if (use_redirect) {
>>                          printf("Creating local redirect\n");
>>
>> -                       dev_fd = open_channel(hci_index);
>> +                       dev_fd = open_channel(HCI_INDEX_NONE);
>>                  } else {
>>                          printf("Connecting to %s:%u\n", connect_address,
>>                                                                  tcp_port);
>> --
>> 2.25.1
>>
>

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718

