Return-Path: <cyrus@holtmann.org>
Message-ID: <dd18b0c30810191306t795dbbabq64645d903568c3c9@mail.gmail.com>
Date: Sun, 19 Oct 2008 13:06:12 -0700
From: "Justin Mattock" <justinmattock@gmail.com>
To: "Jiri Kosina" <jkosina@suse.cz>
Subject: Re: several messages
Cc: "Jiri Slaby" <jirislaby@gmail.com>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Steven Noonan" <steven@uplinklabs.net>,
	"Sven Anders" <anders@anduras.de>,
	"Marcel Holtmann" <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <alpine.LNX.1.10.0810192135010.27479@jikos.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1224425749-22652-1-git-send-email-jirislaby@gmail.com>
	 <1224425749-22652-2-git-send-email-jirislaby@gmail.com>
	 <alpine.LNX.1.10.0810192135010.27479@jikos.suse.cz>
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Oct 19, 2008 at 12:40 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Sun, 19 Oct 2008, Jiri Slaby wrote:
>
>> +enum hid_type {
>> +     HID_TYPE_UNKNOWN = 0,
>> +     HID_TYPE_MOUSE,
>> +     HID_TYPE_KEYBOARD
>> +};
>> +
>
> Do we really need the HID_TYPE_KEYBOARD at all? It's not used anywhere in
> the code. I'd propose to add it when it is actually needed. I.e. have the
> enum contain something like HID_TYPE_MOUSE HID_TYPE_OTHER for now, and add
> whatever will become necessary in the future, what do you think?
>
>
> On Sun, 19 Oct 2008, Jiri Slaby wrote:
>
>> +/**
>> + * hid_mouse_ignore_list - mouse devices which must not be held by the hid layer
>> + */
>
> I think a more descriptive comment would be appropriate here. It might not
> be obvious on the first sight why this needs to be done separately from
> the generic hid_blacklist. I.e. something like
>
> /**
>  * There are composite devices for which we want to ignore only a certain
>  * interface. This is a list of devices for which only the mouse interface
>  * will be ignored.
>  */
>
> maybe?
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

I can agree with that, whats the point having something
there if it not being used,(just eating up precious space);

-- 
Justin P. Mattock
