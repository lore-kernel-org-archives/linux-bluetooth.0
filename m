Return-Path: <cyrus@holtmann.org>
Message-ID: <551CA5BC.5040307@gmail.com>
Date: Thu, 02 Apr 2015 04:13:16 +0200
From: Florian Grandel <fgrandel@gmail.com>
MIME-Version: 1.0
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: How to get the hci_dev from an adv instance's work struct in a linked
 list?
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

I got quite far today refactoring from

struct hci_dev { ... struct adv_info adv_instance; ... };

to

struct hci_dev { ... struct list_head adv_instances; ... };

But in the end I got stuck on refactoring the adv timeout callback. 
Originally it looked like this:

static void adv_timeout_expired(struct work_struct *work)
{
   struct hci_dev *hdev = container_of(work, struct hci_dev,
                                       adv_instance.timeout_exp.work);
   ...
}

But now I would have to construct a pointer to the hci_dev struct from a 
list entry:

static void adv_timeout_expired(struct work_struct *work)
{
   struct adv_info *adv_instance = container_of(work, struct adv_info,
                                                timeout_exp.work);
   ...
}

I couldn't find a way to get the list head of the adv info list entry so 
that I could retrieve its containing hci_dev structure, though.

How would I construct the required hci_dev struct from the work pointer 
in this case? Any ideas?

Florian
