Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130404044332.GA30908@echo>
References: <1363655144-9705-1-git-send-email-deymo@chromium.org>
 <1364863226-10566-1-git-send-email-deymo@chromium.org> <1364863226-10566-2-git-send-email-deymo@chromium.org>
 <51314AAB-DED8-49D6-ACF9-C5658B5948F1@holtmann.org> <20130404044332.GA30908@echo>
From: Alex Deymo <deymo@chromium.org>
Date: Thu, 4 Apr 2013 12:13:39 -0700
Message-ID: <CAGd9gwiJxU0oDh4-rkw7moQhsT07AF0td27kt0u9hQa-_Ex-Sw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] input: Documentation for new Input1 interface
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	keybuk <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Apr 3, 2013 at 9:43 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> Just for fun, the only idea that I could come up with is: "ReconnectionMode"
> or "Mode" with two values: "active" (the remote is not normally connectable,
> but is able to initiate connections), "passive" (the remote is not able to
> initiate connections but is normally connectable) and "dual".
>
> Alex, does something like this cover the use cases that you have in mind?
>
Hi!
The HID profile spec [1], page 77, Table 5.7, defines the four values
as valid (True/False for each property). I don't know any device that
has both values in False, and it looks kind of weird to have to click
some sort of hidden connect button in a input only HID device every
time you want to reconnect since you can do data-driven reconnections,
but well, the specs allows that option. The important thing here is
that these four values are meaningful to the user interface and we
should export them in some way, because you have to notify the user to
do actions like "please, move your mouse to reconnect" or "please,
click the connect button in your mouse to reconnect" or similar
messages in situations where the host can't simply reconnect to the
device with user interaction.

I agree that the spec names aren't the best ones, but at least are the
standard names defined in the spec. Exporting two boolean properties
with different names than the spec will simply add more noise. Combine
both properties in one "ReconnectionMode" looks better to me since
both variables are coupled in the mentioned table, but it will have
the four values ("none", "active", "passive", "dual").

Other option:
"ReconnectInitiator": "none", "device", "host", "both"

Tell me which one do you like the most.
Cheers,
Alex.

[1] https://www.bluetooth.org/docman/handlers/downloaddoc.ashx?doc_id=246761


> Cheers,
> --
> Vinicius
