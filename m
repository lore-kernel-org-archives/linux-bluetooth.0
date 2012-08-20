Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120818182815.GC30527@echo>
References: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1345272662-2850-10-git-send-email-lucas.demarchi@profusion.mobi>
	<20120818182815.GC30527@echo>
Date: Mon, 20 Aug 2012 10:14:07 +0300
Message-ID: <CABBYNZ+k96H9YAzuePJxm-sG5QkeKfdsfA34Et1G5_o9iz5WZA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 09/15] gdbus: Group interface changes to reduce
 the amount of signals emitted
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Sat, Aug 18, 2012 at 9:28 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
>>  static struct interface_data *find_interface(GSList *interfaces,
>> @@ -440,6 +495,7 @@ static struct interface_data *find_interface(GSList *interfaces,
>>
>>       for (list = interfaces; list; list = list->next) {
>>               struct interface_data *iface = list->data;
>> +
>
> Seems I have a special talent for spotting these things (on others patches
> ;-))
>

Also fixed now, thanks

-- 
Luiz Augusto von Dentz
