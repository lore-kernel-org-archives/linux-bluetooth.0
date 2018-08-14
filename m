Return-Path: <arndbergmann@gmail.com>
MIME-Version: 1.0
References: <20180813220419.4168133-1-arnd@arndb.de> <60279ff9-95a7-c2d8-dcd3-6e505c22a0e6@redhat.com>
In-Reply-To: <60279ff9-95a7-c2d8-dcd3-6e505c22a0e6@redhat.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 14 Aug 2018 10:42:31 +0200
Message-ID: <CAK8P3a3QwP9qA-sjCn8UFKHPFzku0epxi6BWETpH9YTEfjQ5jA@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: hci_h5: avoid unused variable warnings
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, jeremy@jcline.org,
	Kees Cook <keescook@chromium.org>,
	Bluez mailing list <linux-bluetooth@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Aug 14, 2018 at 9:22 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Arnd,
>
> On 14-08-18 00:04, Arnd Bergmann wrote:
> > When CONFIG_BT_HCIUART_RTL is disabled, the hci_h5 driver produces a build
> > warning because of an incorrect set of #ifdef guards:
> >
> > drivers/bluetooth/hci_h5.c:920:22: error: 'rtl_vnd' defined but not used [-Werror=unused-variable]
> >
> > Replacing the #ifdef with an IS_ENABLED() check shuts up the error
> > and simplifies the logic.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Hmm, so now you're counting on dead code elimination to remove
> references to unavailable symbols.

Generally depending on dead code elimination is very reliable, as this
is easy for gcc to get right. However, you are right that this is actually
an exception since the MODULE_DEVICE_TABLE() entry will keep
a reference around that prevents the compiler from eliminating it.

> I'm not sure I like this and
> since Marcel has also indicated the does not like this fix I
> believe we need another fix.
>
> I will write another fix for this.
>

Ok, thanks!

      Arnd
