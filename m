Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: Provide L2CAP ops callback for memcpy_fromiovec
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1402937148-11662-1-git-send-email-marcel@holtmann.org>
Date: Tue, 17 Jun 2014 12:19:08 +0200
Message-Id: <AA623CB8-253C-4427-A204-6EAA3927B163@holtmann.org>
References: <1402937148-11662-1-git-send-email-marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> The highly optimized TX path for L2CAP channels and its fragmentation
> within the HCI ACL packets requires to copy data from user provided
> IO vectors and also kernel provided memory buffers.
> 
> This patch allows channel clients to provide a memcpy_fromiovec callback
> to keep this optimized behavior, but adapt it to kernel vs user memory
> for the TX path. For all kernel internal L2CAP channels, a default
> implementation is provided that can be referenced.
> 
> In case of A2MP, this fixes a long-standing issue with wrongly accessing
> kernel memory as user memory.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> Tested-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>

so this patch is bogus as well. This is tough problem to solve :(

reproduce: make C=1 CF=-D__CHECK_ENDIAN__

sparse warnings: (new ones prefixed by >>)

  include/net/bluetooth/l2cap.h:870:42: sparse: incorrect type in argument 2 (different address spaces)
  include/net/bluetooth/l2cap.h:870:42:    expected void const *from
  include/net/bluetooth/l2cap.h:870:42:    got void [noderef] <asn:1>*iov_base

vim +870 include/net/bluetooth/l2cap.h

  854	static inline void l2cap_chan_no_set_shutdown(struct l2cap_chan *chan)
  855	{
  856	}
  857	
  858	static inline long l2cap_chan_no_get_sndtimeo(struct l2cap_chan *chan)
  859	{
  860		return 0;
  861	}
  862	
  863	static inline int l2cap_chan_no_memcpy_fromiovec(struct l2cap_chan *chan,
  864							 unsigned char *kdata,
  865							 struct iovec *iov, int len)
  866	{
  867		while (len > 0) {
  868			if (iov->iov_len) {
  869				int copy = min_t(unsigned int, len, iov->iov_len);
>>870				memcpy(kdata, iov->iov_base, copy);
  871				len -= copy;
  872				kdata += copy;
  873				iov->iov_base += copy;
  874				iov->iov_len -= copy;
  875			}
  876			iov++;
  877		}
  878	

The problem is that is that iov_base is defined with __user in linux/uio.h.

struct iovec
{
        void __user *iov_base;  /* BSD uses caddr_t (1003.1g requires void *) */
        __kernel_size_t iov_len; /* Must be size_t (1003.1g) */
};

This means we need to rethink this whole approach once more.

Regards

Marcel

