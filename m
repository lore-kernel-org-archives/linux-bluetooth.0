Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLLgdRGzrY7z_8Nz8OeXtmapvsoKiQHL6UHLzuyqy=8HQ@mail.gmail.com>
References: <1345816795-14092-1-git-send-email-luiz.dentz@gmail.com>
	<1345816795-14092-7-git-send-email-luiz.dentz@gmail.com>
	<20120828011708.GA11305@x220.sheraton.com>
	<CABBYNZLLgdRGzrY7z_8Nz8OeXtmapvsoKiQHL6UHLzuyqy=8HQ@mail.gmail.com>
Date: Tue, 28 Aug 2012 12:24:32 +0300
Message-ID: <CABBYNZJ0ZgP4wv2Oqetq49mDPOezsHvLiWUaQBOTsQzyfTGFdA@mail.gmail.com>
Subject: Re: [PATCH obexd 7/7] client-doc: Update documentation of
 PhonebookAccess interface
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Aug 28, 2012 at 10:00 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>>> +                             array{string} Fields:
>>> +
>>> +                                     Item vcard fields, default is all
>>> +                                     values.
>>> +
>>> +                                     Possible values:
>>> +
>>> +                                             "VERSION",
>>> +                                             "FN",
>>> +                                             "N",
>>> +                                             "PHOTO",
>>> +                                             "BDAY",
>>> +                                             "ADR",
>>> +                                             "LABEL",
>>> +                                             "TEL",
>>> +                                             "EMAIL",
>>> +                                             "MAILER",
>>> +                                             "TZ",
>>> +                                             "GEO",
>>> +                                             "TITLE",
>>> +                                             "ROLE",
>>> +                                             "LOGO",
>>> +                                             "AGENT",
>>> +                                             "ORG",
>>> +                                             "NOTE",
>>> +                                             "REV",
>>> +                                             "SOUND",
>>> +                                             "URL",
>>> +                                             "UID",
>>> +                                             "KEY",
>>> +                                             "NICKNAME",
>>> +                                             "CATEGORIES",
>>> +                                             "PROID",
>>> +                                             "CLASS",
>>> +                                             "SORT-STRING",
>>> +                                             "X-IRMC-CALL-DATETIME"
>>
>> Make these lower case (I know it's upper case in the spec. but let's
>> keep the consistency with the rest of the D-Bus API).

So what about the following:

					Possible values:

						"version",
						"formatted-name",
						"name",
						"photo",
						"birthday",
						"address",
						"label",
						"telephone",
						"email",
						"mailer",
						"time-zone",
						"location",
						"title",
						"role",
						"logo",
						"agent",
						"organization",
						"note",
						"revision",
						"source",
						"url",
						"uid",
						"key",
						"nickname",
						"categories",
						"product",
						"class",
						"sort-string",
						"timestamp"

-- 
Luiz Augusto von Dentz
