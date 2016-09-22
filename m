Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1474490152-627-1-git-send-email-szymon.janc@codecoup.pl>
References: <1474490152-627-1-git-send-email-szymon.janc@codecoup.pl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 22 Sep 2016 11:06:18 +0300
Message-ID: <CABBYNZL=Kj0_StweJBE736me1dYxPZfKH7okpSkNyFvboGz=nA@mail.gmail.com>
Subject: Re: [PATCH 1/2] test/example-gatt-server: Fix few copy-paste errors
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Sep 21, 2016 at 11:35 PM, Szymon Janc <szymon.janc@codecoup.pl> wrote:
> ---
>  test/example-gatt-server | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/test/example-gatt-server b/test/example-gatt-server
> index 44ceb70..ecf614f 100755
> --- a/test/example-gatt-server
> +++ b/test/example-gatt-server
> @@ -535,11 +535,11 @@ class TestEncryptCharacteristic(Characteristic):
>                  CharacteristicUserDescriptionDescriptor(bus, 3, self))
>
>      def ReadValue(self, options):
> -        print('TestCharacteristic Read: ' + repr(self.value))
> +        print('TestEncryptCharacteristic Read: ' + repr(self.value))
>          return self.value
>
>      def WriteValue(self, value, options):
> -        print('TestCharacteristic Write: ' + repr(value))
> +        print('TestEncryptCharacteristic Write: ' + repr(value))
>          self.value = value
>
>  class TestEncryptDescriptor(Descriptor):
> @@ -576,16 +576,16 @@ class TestSecureCharacteristic(Characteristic):
>                  ['secure-read', 'secure-write'],
>                  service)
>          self.value = []
> -        self.add_descriptor(TestEncryptDescriptor(bus, 2, self))
> +        self.add_descriptor(TestSecureDescriptor(bus, 2, self))
>          self.add_descriptor(
>                  CharacteristicUserDescriptionDescriptor(bus, 3, self))
>
>      def ReadValue(self, options):
> -        print('TestCharacteristic Read: ' + repr(self.value))
> +        print('TestSecureCharacteristic Read: ' + repr(self.value))
>          return self.value
>
>      def WriteValue(self, value, options):
> -        print('TestCharacteristic Write: ' + repr(value))
> +        print('TestSecureCharacteristic Write: ' + repr(value))
>          self.value = value
>
>
> --
> 2.7.4

Applied, thanks.

-- 
Luiz Augusto von Dentz
