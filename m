Return-Path: <cyrus@holtmann.org>
Message-ID: <4BC33E82.6090104@hschmitt.de>
Date: Mon, 12 Apr 2010 17:38:42 +0200
From: Harald Schmitt <commerce@hschmitt.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: obexd and phonebook-ebook.c (PBAP support)
References: <4BB4B789.7070409@hschmitt.de> <4BB9A104.3050509@hschmitt.de>
In-Reply-To: <4BB9A104.3050509@hschmitt.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Harald Schmitt schrieb:
> Harald Schmitt schrieb:
>> Hi,
>>
>> Is it possible that obexd has to call g_type_init() if 
>> phonebook-ebook is used?
>> I think when you call e_book_new_default_addressbook() somewhere down 
>> gconf_client_get_default() is called and it insists that 
>> g_type_init() is called prior to its use.
>>
>> I tried to make obexd work on my N900, but I did not get there.
>> My car kit does not use PBAP because it finds the Nokia SyncML 
>> profile and uses it, but the N900 does not communicate with bluetooth 
>> devices other than PC or Mobiles via SyncML.
>> Is there a way to unregister a service from SDP?
>>
>> Regards,
>>
>> -- 
>> Harald
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> Now I am using pbap-client from the obexd package from my notebook to 
> test pbap on my N900. I am pretty far. All my contacts are read, but 
> the obex message is not sent back successfully.
> Here is the syslog (I added some messages):
> Apr  5 09:56:35 Nokia-N900-51-1 obexd[1203]: pbap_get: pbap_get()
> Apr  5 09:56:35 Nokia-N900-51-1 obexd[1203]: phonebook_pullphonebook: 
> phonebook_pullphonebook
> Apr  5 09:56:36 Nokia-N900-51-1 obexd[1203]: pbap_pullphonebook: 
> phonebook_pullphonebook had no errors
> Apr  5 09:56:36 Nokia-N900-51-1 obexd[1203]: 
> pbap_add_result_apparam_header: pbap_add_result_apparam_header 
> maxlistcount=65535 rspsize=0
> Apr  5 09:56:36 Nokia-N900-51-1 obexd[1203]: pbap_get: pbap_get() no 
> error
> Apr  5 09:56:36 Nokia-N900-51-1 obexd[1203]: pbap_get: pbap_get() addbody
> Apr  5 09:56:36 Nokia-N900-51-1 obexd[1203]: pbap_get: pbap_get() 
> OBEX_ObjectSetRsp()
> Apr  5 09:56:36 Nokia-N900-51-1 obexd[1203]: PROGRESS(0x0), GET(0x3), 
> (null)(0x0)
> Apr  5 09:56:36 Nokia-N900-51-1 obexd[1203]: ebookpull_cb: 
> ebookpull_cb count=305 size=42944
> Apr  5 09:56:36 Nokia-N900-51-1 obexd[1203]: STREAMEMPTY(0x8), 
> CONNECT(0x0), (null)(0x0)
> Apr  5 09:56:36 Nokia-N900-51-1 obexd[1203]: obex_write_stream: 
> name=telecom/pb.vcf type=x-bt/phonebook tx_mtu=3896 file=(nil)
> Apr  5 09:56:36 Nokia-N900-51-1 obexd[1203]: STREAMEMPTY(0x8), 
> CONNECT(0x0), (null)(0x0)
> Apr  5 09:56:36 Nokia-N900-51-1 obexd[1203]: obex_write_stream: 
> name=telecom/pb.vcf type=x-bt/phonebook tx_mtu=3896 file=(nil)
> Apr  5 09:56:36 Nokia-N900-51-1 obexd[1203]: PROGRESS(0x0), 
> (null)(0x10), (null)(0x0)
> Apr  5 09:56:37 Nokia-N900-51-1 obexd[1203]: REQDONE(0x3), 
> (null)(0x10), (null)(0x3)
> Apr  5 09:57:00 Nokia-N900-51-1 obexd[1203]: obex_handle_input: poll 
> event HUP ERR
>
> Best,
> Harald
I think the problem on my N900 is a bug in openobex 1.4, that is fixed 
in 1.5:
http://git.kernel.org/?p=bluetooth/openobex.git;a=commit;h=52bf1445d2fa4b95dac4b98e1cb6e9dbb5d5ed7d
This situation applies on the way the PBAP plugin is implemented. To 
make PBAP working with only replacing obexd, I think the only way is to 
use the non-async e-book functions or could someone give me a hint to 
something better?

Best,
Harald
