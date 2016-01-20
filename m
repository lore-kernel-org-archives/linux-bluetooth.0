Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Jan 2016 13:58:41 +0100
Message-ID: <CAA+NYvTV6WybKuO71Gehm6L2-vjsqVhmu5VjEQCfqFaWi1TU6Q@mail.gmail.com>
Subject: [BUG] Btattach, ioctl fails to set flags from 32-bit user space to 64-bit
From: Jaap Jan Meijer <jjmeijer88@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

WIth Btattach, ioctl fails to set flags from 32-bit user space to 64-bit
kernel. ioctl fails with ENOTTY.

static int attach_proto(const char *path, unsigned int proto,
unsigned int flags)
{
int fd, dev_id;

fd = open_serial(path);
if (fd < 0)
return -1;

if (ioctl(fd, HCIUARTSETFLAGS, flags) < 0) {
perror("Failed to set flags");
close(fd);
return -1;
}
.....

Kind regards,

J.J.
