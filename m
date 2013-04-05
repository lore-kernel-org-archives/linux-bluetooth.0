Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130404214444.GA7065@echo>
References: <1365111113-13741-1-git-send-email-deymo@chromium.org> <20130404214444.GA7065@echo>
From: Alex Deymo <deymo@chromium.org>
Date: Thu, 4 Apr 2013 19:47:17 -0700
Message-ID: <CAGd9gwgGiFzZBDRNAgb9Xcf5vxeYW-Xz_0CjOgW=50ei8bRFxg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Input1 Connectability revisited
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	keybuk <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Apr 4, 2013 at 2:44 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> Sounds good to me. Just please change to lower case names to maintain
> consistency with the rest of the API, see media-api.txt, for example.

Ok. I changed this and the reconnect_mode_to_string() thing. Also
split the part about the gboolean in another commit. For some reason I
though the upper case was the consistent with rest of the API, but now
I see that is not the case for property values.
I'll wait until tomorrow to see if someone else has another comment
over this approach and send all the changes together.
Thanks!
Alex.
