Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Colin Pinkney <bluez-devel@cpinkney.org.uk>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200501102004.11028.bluez-devel@cpinkney.org.uk>
Subject: [Bluez-devel] sockfd_lookup missing from older kernel patches
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 10 Jan 2005 20:04:10 +0000

Hi,

I was updating a BlueZ package for the Sharp Zaurus PDAs that use the 2.4.18 
kernel. The previous package had been using BlueZ libs and utils v2.3 and 
patch 2.4.18-mh8 and had been working ok.

With the latest userspace source and patch 2.4.18-mh15 I noticed the function 
sockfd_lookup had been removed from the sock.c files. This caused a 
unresolved symbol error upon loading the bnep module on the Zaurus.

I noticed in the comments on http://www.holtmann.org/linux/kernel/ that 
sockfd_lookup was removed on Dec 15, 2003 from kernel patches for kernels 
2.4.22 and later. I presume this function has been moved into more central 
kernel code? Was this function supposed to be removed from the patches for 
kernels 2.4.21 and earlier (or at least kernel 2.4.18)?

When I stuck the code below back into bnep/sock.c the module loaded properly 
(although I need to test functionality a bit more as I got the code from the 
patch 2.4.18-mh8).

<<<<<
static inline struct socket *socki_lookup(struct inode *inode)
{
       return &inode->u.socket_i;
}

static struct socket *sockfd_lookup(int fd, int *err)
{
       struct file *file;
       struct inode *inode;
       struct socket *sock;

       if (!(file = fget(fd))) {
               *err = -EBADF;
               return NULL;
       }

       inode = file->f_dentry->d_inode;
       if (!inode->i_sock || !(sock = socki_lookup(inode))) {
               *err = -ENOTSOCK;
               fput(file);
               return NULL;
       }

       if (sock->file != file) {
               printk(KERN_ERR "socki_lookup: socket file changed!\n");
               sock->file = file;
       }
       return sock;
}
>>>>>

Regards,

-- 
Colin Pinkney
http://www.cpinkney.org.uk


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
