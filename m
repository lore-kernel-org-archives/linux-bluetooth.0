Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E98EC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 21:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E5723C44
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Dec 2020 21:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388322AbgLIVsb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Dec 2020 16:48:31 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:34285 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388305AbgLIVsb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Dec 2020 16:48:31 -0500
Received: from [192.168.100.1] ([82.252.152.214]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M4s8v-1koUKH0dh1-001z21; Wed, 09 Dec 2020 22:45:58 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
References: <3a6fa942-bec5-5e5f-391d-197d1c1eafa6@vivier.eu>
 <e885258a0b9a3ba15640553e9f002cdfc89f4b79.camel@hadess.net>
 <73236e71-781f-1dea-13d5-61fdc45d5e13@vivier.eu>
 <0eeb1a4a1254d00b2d1a8f77133af4d16857b266.camel@hadess.net>
 <ab6ae9d9-9104-5454-d93d-b734c0eb9eba@vivier.eu>
 <50264b155ddf8b677125b87a703a628f76518457.camel@hadess.net>
Subject: Re: Bluetooth printer connection error
Message-ID: <8066fc64-5528-0952-e23a-49026bea39fc@vivier.eu>
Date:   Wed, 9 Dec 2020 22:45:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <50264b155ddf8b677125b87a703a628f76518457.camel@hadess.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/8PWwqtabsVgbgfwNGRDACVjYhZpdXk2pwKYsTOx4dvQiJfONQs
 YTq3pGGVE8sqDsDm9cK1c5AuGR2FdaAsmBNxZEPlBcSe/fszXH2ISKCqOqiFKdjnLNgfzCO
 zeIHveuUAwOVWAqD6Op3u/YR+9EITUABHMTti0qT47LotNTvKTE4dQjstZVuYRI1pss8iyM
 BiQAY2ecFcu8R3MG0xWig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pdhLs3Dhs8U=:FAL3hWG39sp+WDN3XMVZvf
 QqXDfqCUA3Lq4fgu0k1JV9Wy+Zohkz/9b3kmaG8oAN3OPpUA8KI40MW1RvsRz02a2g6M0exPy
 v8TYqisCJEppBYHeEwFKMZrRKu7pBRko0UaffbmkmHHedz9H/We/N6ZmpHkhobdF6dvCjzjPp
 1I+Q9y2Ija18rRbqeQdWQXwRuZPl8L6x6ic18WeXQE+fARYtiKRF3RuFKI94S6KmqHsRCRKHS
 jDvQzPHuxBj/YHpmouFUBBcmRA7rhLFFwHiAWZlmV5Au1qh7zzIrm9DdMXNqRW9XhwHsGcOjK
 RYX2g3eoutJ7Q+tS0KJ1F1GOIktUCLzQC92MqAW1VwGT7XL+FQ4MfUKTis5uXGwVqMejb33Lo
 W7ezmPzUBOBXLux1m3hE75HY9CWFTQIqAZ1pHuJS1D4f9KN+F9cLEkbk8OKRBBoN56327Hwa/
 aFFRBl7++w==
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Le 09/12/2020 à 21:27, Bastien Nocera a écrit :
> On Wed, 2020-12-09 at 20:04 +0100, Laurent Vivier wrote:
>> Le 09/12/2020 à 12:34, Bastien Nocera a écrit :
>>> On Wed, 2020-12-09 at 12:14 +0100, Laurent Vivier wrote:
>> ...
>>>>> If the printer has uses the SPP or HCRP printing profiles, you
>>>>> should
>>>>> see it when using:
>>>>> /usr/lib/cups/backend/bluetooth
>>>>> without any arguments.
>>>>
>>>> As I don't see it once it is paired, I guess it is not using one
>>>> of
>>>> these profiles.
>>>
>>> I don't remember how this used to work, but you'll probably only
>>> see
>>> something if the printer is visible.
>>>
>>> You might be able to get the printer to work by adding:
>>> bluetooth://DC0D309023C7
>>> as a printer in the printer settings of your favourite desktop
>>> environment, if it actually uses SPP.
>>>
>>> running the cups backend with:
>>> /usr/lib/cups/backend/bluetooth --get-deviceid
>>> bluetooth://DC0D309023C7
>>>
>>> should show you whether it can get autoconfigured for CUPS use.
>>>
>>
>> Thank you Bastien, it's exactly what I needed to know.
>>
>> Correct me if I'm wrong but it seems there is a bug in the
>> cups/bluetooth
>> command:
> 
> Sigh. No, it's not a bug, it's just that the cups tool was never ported
> from the bluez 4.x to the current bluez 5.x API...
> 
> Until that's ported (if ever, given the low number of Bluetooth
> printers around...), you could try to extract the IEEE1284 ID using:
> sdptool records DC:0D:30:90:23:C7

$ sdptool records DC:0D:30:90:23:C7
Service Name: SPP Dev
Service RecHandle: 0x10001
Service Class ID List:
  "Serial Port" (0x1101)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100

It doesn't seem to provide an IEEE1284 ID.

> 
> But I'm not certain that this working is necessary to actually try a
> print. Have you tested that?
> 

Not sure what to do...

If I try to add the printer using the GUI, it doesn't appear in the list and I cannot add it
manually (Fedora 33/GNOME 3.38.2) in GUI.

If I add it with the following command line:

  lpadmin -p M02 -E -v bluetooth://DC0D309023C7 -P /usr/share/cups/model/Phomemo/Phomemo-M02.ppd.gz

It doesn't print anything.

But I had some selinux related error:

setroubleshoot[13488]: SELinux interdit à bluetooth d'utiliser l'accès connect sur le
bluetooth_socket Inconnu.Pour des messages SELinux exhaustifs, lancez sealert -l
965e2270-948f-4791-93f0-3b856c162cea
setroubleshoot[13488]: SELinux interdit à bluetooth d'utiliser l'accès connect sur le
bluetooth_socket Inconnu.
...

So I ran:

  ausearch -c "bluetooth" --raw | audit2allow -M my-bluetooth
  semodule -X 300 -i my-bluetooth.pp

And now what I have in the syslogs is:

cupsd[1185]: REQUEST localhost - - "POST /printers/M02 HTTP/1.1" 200 499560 Print-Job successful-ok
DC0D309023C7[14310]: sdp_send_req_w4_rsp: Error sending data:Permission denied
DC0D309023C7[14310]: sdp_service_search_attr_req: Unexpected end of packet
DC0D309023C7[14310]: sdp_send_req_w4_rsp: Error sending data:Permission denied
DC0D309023C7[14310]: sdp_service_search_attr_req: Unexpected end of packet
cupsd[1185]: Can\'t get service information
DC0D309023C7[14310]: sdp_send_req_w4_rsp: Error sending data:Permission denied
DC0D309023C7[14310]: sdp_service_search_attr_req: Unexpected end of packet

Thanks,
Laurent

