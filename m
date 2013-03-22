Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHZ1yCmkO_-edONxyNGzXohyTc+5JoUr4aCCK0+_XXX7vXbJ0A@mail.gmail.com>
References: <1363839008-8405-1-git-send-email-deymo@chromium.org>
	<1363839008-8405-3-git-send-email-deymo@chromium.org>
	<CAHZ1yCmkO_-edONxyNGzXohyTc+5JoUr4aCCK0+_XXX7vXbJ0A@mail.gmail.com>
Date: Fri, 22 Mar 2013 11:06:56 +0100
Message-ID: <CANq1E4R96J_sMzrnczbGYnzLGWQfLoH9K+mU0WpLppkm+u1jVA@mail.gmail.com>
Subject: Re: [PATCH 2/6] plugins: Extend the pin code callback with the call number
From: David Herrmann <dh.herrmann@gmail.com>
To: Scott James Remnant <keybuk@chromium.org>
Cc: Alex Deymo <deymo@chromium.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott

On Fri, Mar 22, 2013 at 12:12 AM, Scott James Remnant
<keybuk@chromium.org> wrote:
> On Wed, Mar 20, 2013 at 9:10 PM, Alex Deymo <deymo@chromium.org> wrote:
>
>> +       /* Only try the pin code once per device. If it's not correct then it's
>> +        * an unknown device. */
>> +       if (count > 0)
>> +               return 0;
>> +
>
> Semi-interesting fact:
>
> There are actually two possible PINs for a wiimote, depending which
> pairing mode is used. This plugin could be used to iterate between
> them.

No, you cannot. The Wii Remote closes the connection after a failed
attempt (at least some revisions do). And after a reconnect, you
cannot be sure that the old PIN is still wrong.

Hence, the only recommended way to pair Wii Remotes is via the "red
sync" button on the back.
I'm currently trying to find a way to distinguish both connection
methods before pairing, but I haven't succeeded, yet.

Regards
David
