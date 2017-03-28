Return-Path: <luiz.von.dentz@intel.com>
MIME-Version: 1.0
In-Reply-To: <368A8A18-0B9B-4733-86EF-D44C8E9CAE36@holtmann.org>
References: <20170328132935.382216-1-arnd@arndb.de> <368A8A18-0B9B-4733-86EF-D44C8E9CAE36@holtmann.org>
From: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Date: Tue, 28 Mar 2017 16:42:50 +0300
Message-ID: <CACumGO+QvuyDg21yogaUn1WCHv2S3=_DXD+My0Q6ANYE1NYKzg@mail.gmail.com>
Subject: Re: [PATCH] 6lowpan: set peer_addr correctly again
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Stefan Schmidt <stefan@osg.samsung.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>,
	Eric Dumazet <edumazet@google.com>, Patrik Flykt <patrik.flykt@linux.intel.com>,
	Alexander Aring <aar@pengutronix.de>, Glenn Ruben Bakke <glennrubenbakke@nordicsemi.no>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Mar 28, 2017 at 4:37 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Arnd,
>
>> A bugfix accidentally changed one line to return the peer_addr
>> from setup_header, causing it to become unused:
>>
>> net/bluetooth/6lowpan.c: In function 'setup_header':
>> net/bluetooth/6lowpan.c:402:14: error: parameter 'peer_addr' set but not=
 used [-Werror=3Dunused-but-set-parameter]
>>
>> The only user of the variable is a subsequent printk(), and
>> it is not otherwise initialized, so reverting the changed line
>> looks like the right fix.
>>
>> Fixes: fb6f2f606ce8 ("6lowpan: Fix IID format for Bluetooth")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> net/bluetooth/6lowpan.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> I took Colin=E2=80=99s patch since it showed up first in my inbox.

Thanks, I might be missing something since the error doesn't show up for me=
:

  CC [M]  net/bluetooth/6lowpan.o
  LD [M]  net/bluetooth/bluetooth_6lowpan.o
