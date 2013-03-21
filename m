Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: keybuk@google.com
In-Reply-To: <1363839008-8405-3-git-send-email-deymo@chromium.org>
References: <1363839008-8405-1-git-send-email-deymo@chromium.org>
	<1363839008-8405-3-git-send-email-deymo@chromium.org>
Date: Thu, 21 Mar 2013 16:12:01 -0700
Message-ID: <CAHZ1yCmkO_-edONxyNGzXohyTc+5JoUr4aCCK0+_XXX7vXbJ0A@mail.gmail.com>
Subject: Re: [PATCH 2/6] plugins: Extend the pin code callback with the call number
From: Scott James Remnant <keybuk@chromium.org>
To: Alex Deymo <deymo@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Mar 20, 2013 at 9:10 PM, Alex Deymo <deymo@chromium.org> wrote:

> +       /* Only try the pin code once per device. If it's not correct then it's
> +        * an unknown device. */
> +       if (count > 0)
> +               return 0;
> +

Semi-interesting fact:

There are actually two possible PINs for a wiimote, depending which
pairing mode is used. This plugin could be used to iterate between
them.

Scott
--
Scott James Remnant | Chrome OS Systems | keybuk@google.com | Google
