Return-Path: <cyrus@holtmann.org>
From: "Zhang, Zhenhua" <zhenhua.zhang@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 23 Aug 2010 09:13:50 +0800
Subject: RE: [PATCH 0/8] Clean up Obex btio.[ch] and make it self contained
Message-ID: <33AB447FBD802F4E932063B962385B352A3545C9@shsmsx501.ccr.corp.intel.com>
References: <1282227676-15381-1-git-send-email-zhenhua.zhang@intel.com>
 <AANLkTi=B=GoXrymjfKAnXuRDiTe7Uxqdiqs831nsWRb-@mail.gmail.com>
In-Reply-To: <AANLkTi=B=GoXrymjfKAnXuRDiTe7Uxqdiqs831nsWRb-@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Thu, Aug 19, 2010 at 5:21 PM, Zhenhua Zhang
> <zhenhua.zhang@intel.com> wrote: 
>> Hi,
>> 
>> This series of patches is to seperate btio.[ch] from src to btio
>> directory. To make btio.[ch] self contained for obexd, there're some
>> cleanup work:  
> 
> Sounds good, this should make it easier to maintain those in sync with
> other projects using it.
> 
>> 1. remove unused bt_io_set(). It is neither used by bluez or obexd.
>> 2. remove unused SCO/L2RAW related code for Obexd. Note: BlueZ code
>> requires SCO/L2RAW related functions. We may consider to add them
>> back later.  
> 
> Im not so sure if we want to have this code removed, obviously after
> that in case of changes/fixes they may not apply cleanly in all
> projects, so keeping them in sync won't be as easy anymore.

You're right. For such code used in BlueZ, I will keep them to make sync easier. So now I am cleaning up BlueZ's btio.[ch]. Before I complete that part, I just want to send out what I plan to change for btio.[ch] to collect review comments earlier. The patches for BlueZ will be send out later.

>> 3. replace void *userdata with gpointer userdata. To make it
>> consistent with bluez btio.c 
>> 4. refactor hci_devba into devid2ba. Remove dependence with hci*.h
>> 5. Remove libbluetooth dependence for obexd.
> 
> This is fine as long as the other copies have this changes too.

Regards,
Zhenhua
