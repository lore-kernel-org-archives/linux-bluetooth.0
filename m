Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110309225246.GA3009@piper>
References: <cover.1298307667.git.vinicius.gomes@openbossa.org>
 <02fa778ab4292dffba1330e829b0d4029517a21e.1298307667.git.vinicius.gomes@openbossa.org>
 <20110227202041.GG2166@joana> <AANLkTi=j3REcNM4bXfFJPamPwqazS5k4eGAJf3BpB_Ya@mail.gmail.com>
 <20110228172801.GB2165@joana> <20110303174501.GA10733@piper> <20110309225246.GA3009@piper>
From: Anderson Briglia <anderson.briglia@openbossa.org>
Date: Tue, 15 Mar 2011 15:03:01 -0400
Message-ID: <AANLkTinQh-oM+Dn-j8Rt8s99edozbXFjC-MUwiOLd_y1@mail.gmail.com>
Subject: Re: [bluetooth-next 04/15] Bluetooth: Add support for using the
 crypto subsystem
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

On Wed, Mar 9, 2011 at 6:52 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> On 14:45 Thu 03 Mar, Vinicius Costa Gomes wrote:
>> Hi Marcel,
>>
>> On 14:28 Mon 28 Feb, Gustavo F. Padovan wrote:
>> > Hi Vinicius,
>> >
>> > * Vinicius Gomes <vinicius.gomes@openbossa.org> [2011-02-27 21:49:39 -0300]:
>> >
>> > > Hi Gustavo,
>> > >
>> > > On Sun, Feb 27, 2011 at 5:20 PM, Gustavo F. Padovan
>> > > <padovan@profusion.mobi> wrote:
>> > > > Hi Vinicius,
>> > > >
>> > > > * Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-02-21 14:23:51 -0300]:
>> > > >
>> > > >> This will allow using the crypto subsystem for encrypting data. As SMP
>> > > >> (Security Manager Protocol) is implemented almost entirely on the host
>> > > >> side and the crypto module already implements the needed methods
>> > > >> (AES-128), it makes sense to use it.
>> > > >>
>> > > >> This patch also adds a new Kconfig option to toggle the SMP support.
>> > > >>
>> > > >> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
>> > > >> Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
>> > > >> ---
>> > > >>  include/net/bluetooth/hci_core.h |    2 ++
>> > > >>  net/bluetooth/Kconfig            |    6 ++++++
>> > > >>  net/bluetooth/hci_core.c         |   22 ++++++++++++++++++++++
>> > > >>  net/bluetooth/smp.c              |   17 +++++++++++++++--
>> > > >>  4 files changed, 45 insertions(+), 2 deletions(-)
>> > > >>
>> > > >> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> > > >> index d5d8454..e8dbde8 100644
>> > > >> --- a/include/net/bluetooth/hci_core.h
>> > > >> +++ b/include/net/bluetooth/hci_core.h
>> > > >> @@ -161,6 +161,8 @@ struct hci_dev {
>> > > >>
>> > > >>       __u16                   init_last_cmd;
>> > > >>
>> > > >> +     struct crypto_blkcipher *tfm;
>> > > >> +
>> > > >>       struct inquiry_cache    inq_cache;
>> > > >>       struct hci_conn_hash    conn_hash;
>> > > >>       struct list_head        blacklist;
>> > > >> diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
>> > > >> index c6f9c2f..e9f40af 100644
>> > > >> --- a/net/bluetooth/Kconfig
>> > > >> +++ b/net/bluetooth/Kconfig
>> > > >> @@ -22,6 +22,7 @@ menuconfig BT
>> > > >>            BNEP Module (Bluetooth Network Encapsulation Protocol)
>> > > >>            CMTP Module (CAPI Message Transport Protocol)
>> > > >>            HIDP Module (Human Interface Device Protocol)
>> > > >> +          SMP Module (Security Manager Protocol)
>> > > >>
>> > > >>         Say Y here to compile Bluetooth support into the kernel or say M to
>> > > >>         compile it as module (bluetooth).
>> > > >> @@ -35,11 +36,16 @@ config BT_L2CAP
>> > > >>       bool "L2CAP protocol support"
>> > > >>       depends on BT
>> > > >>       select CRC16
>> > > >> +     select CRYPTO_BLKCIPHER
>> > > >> +     select CRYPTO_AES
>> > > >>       help
>> > > >>         L2CAP (Logical Link Control and Adaptation Protocol) provides
>> > > >>         connection oriented and connection-less data transport.  L2CAP
>> > > >>         support is required for most Bluetooth applications.
>> > > >>
>> > > >> +       Also included is support for SMP (Security Manager Protocol) which
>> > > >> +       is the security layer on top of LE (Low Energy) links.
>> > > >> +
>> > > >>  config BT_SCO
>> > > >>       bool "SCO links support"
>> > > >>       depends on BT
>> > > >> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> > > >> index b372fb8..ff67843 100644
>> > > >> --- a/net/bluetooth/hci_core.c
>> > > >> +++ b/net/bluetooth/hci_core.c
>> > > >> @@ -42,6 +42,7 @@
>> > > >>  #include <linux/notifier.h>
>> > > >>  #include <linux/rfkill.h>
>> > > >>  #include <linux/timer.h>
>> > > >> +#include <linux/crypto.h>
>> > > >>  #include <net/sock.h>
>> > > >>
>> > > >>  #include <asm/system.h>
>> > > >> @@ -60,6 +61,8 @@ static void hci_notify(struct hci_dev *hdev, int event);
>> > > >>
>> > > >>  static DEFINE_RWLOCK(hci_task_lock);
>> > > >>
>> > > >> +static int enable_smp;
>> > > >> +
>> > > >>  /* HCI device list */
>> > > >>  LIST_HEAD(hci_dev_list);
>> > > >>  DEFINE_RWLOCK(hci_dev_list_lock);
>> > > >> @@ -1077,6 +1080,14 @@ static void hci_cmd_timer(unsigned long arg)
>> > > >>       tasklet_schedule(&hdev->cmd_task);
>> > > >>  }
>> > > >>
>> > > >> +static struct crypto_blkcipher *alloc_cypher(void)
>> > > >> +{
>> > > >> +     if (enable_smp)
>> > > >> +             return crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
>> > > >> +
>> > > >> +     return ERR_PTR(-ENOTSUPP);
>> > > >> +}
>> > > >> +
>> > > >>  /* Register HCI device */
>> > > >>  int hci_register_dev(struct hci_dev *hdev)
>> > > >>  {
>> > > >> @@ -1155,6 +1166,11 @@ int hci_register_dev(struct hci_dev *hdev)
>> > > >>       if (!hdev->workqueue)
>> > > >>               goto nomem;
>> > > >>
>> > > >> +     hdev->tfm = alloc_cypher();
>> > > >> +     if (IS_ERR(hdev->tfm))
>> > > >> +             BT_INFO("Failed to load transform for ecb(aes): %ld",
>> > > >> +                                                     PTR_ERR(hdev->tfm));
>> > > >> +
>> > > >>       hci_register_sysfs(hdev);
>> > > >>
>> > > >>       hdev->rfkill = rfkill_alloc(hdev->name, &hdev->dev,
>> > > >> @@ -1203,6 +1219,9 @@ int hci_unregister_dev(struct hci_dev *hdev)
>> > > >>                                       !test_bit(HCI_SETUP, &hdev->flags))
>> > > >>               mgmt_index_removed(hdev->id);
>> > > >>
>> > > >> +     if (!IS_ERR(hdev->tfm))
>> > > >> +             crypto_free_blkcipher(hdev->tfm);
>> > > >> +
>> > > >>       hci_notify(hdev, HCI_DEV_UNREG);
>> > > >>
>> > > >>       if (hdev->rfkill) {
>> > > >> @@ -2037,3 +2056,6 @@ static void hci_cmd_task(unsigned long arg)
>> > > >>               }
>> > > >>       }
>> > > >>  }
>> > > >> +
>> > > >> +module_param(enable_smp, bool, 0644);
>> > > >> +MODULE_PARM_DESC(enable_smp, "Enable SMP support (LE only)");
>> > > >
>> > > > This all should be obviously inside smp.c
>> > >
>> > > I have a couple of points against it:
>> > >
>> > > 1. it's only used for one purpose, it says whether to try or not to
>> > > allocate the block cypher, which is done during the adapter
>> > > registration;
>> > >
>> > > 2. If the current way is ok, it would mean that I would need to export
>> > > another method from smp.c, that was something that I tried to
>> > > minimize;
>> > >
>> > > 3. and my weakest argument, seems that there are other similar uses,
>> > > for example enable_mgmt.
>> >
>> > A similar example here is enable_ertm inside l2cap_core.c. It's a L2CAP
>> > related option and should reside inside L2CAP code.
>> >
>> > >
>> > > But if you think the code will be clearer moving that to smp.c, will
>> > > be glad to change.
>> >
>> > I don't see the point on have it on hci code. SMP and Block cypher has
>> > not much to do with HCI. I prefer it on smp.c
>>
>> Gustavo and I were talking on IRC and couldn't come to a solution, so
>> we ask you for some input.
>>
>> So, just to give a little more context, the problem is that the crypto
>> functions used in SMP depend on the allocation of a block cypher "transform",
>> this allocation must happen during user context.
>>
>> The current solution is that the allocation is done in hci_core.c during the
>> adapter registration, but only when the enable_smp module parameter is enabled.
>> When the parameter is disabled the allocation method just returns an invalid
>> pointer and everything happens the same as if the allocation has failed.
>>
>> Gustavo has a preference for an ondemand aproach, for example, using a
>> workqueue for doing the allocation, and trying the allocation just when SMP is
>> going to be used, e.g. when we receive the first SMP message or when some
>> security level is activated for that socket.
>>
>> Any ideas?
>
> Still no ideas?
>

We at INdT have some patches based on top of this series. What is the
maintainer's opinion about this series? I'm asking it because should
be great to know if we are doing the right stuff or we need to change
our approach. The number of features and patches that have this series
as dependency is growing.

Regards,

Anderson Briglia

>>
>> >
>> > --
>> > Gustavo F. Padovan
>> > http://profusion.mobi
>>
>>
>> Cheers,
>> --
>> Vinicius
>
> --
> Vinicius
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
INdT - Instituto Nokia de tecnologia
+55 2126 1122
http://techblog.briglia.net
