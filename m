Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20141128132747.GA12799@t440s.lan>
References: <1417161184-17663-1-git-send-email-jpawlowski@google.com>
	<1417161184-17663-3-git-send-email-jpawlowski@google.com>
	<20141128132747.GA12799@t440s.lan>
Date: Fri, 28 Nov 2014 16:47:37 -0800
Message-ID: <CAD0=r8xHNy=DqsaZBWU90YdSteqgntdLVsuJMLxy+GNxQ+QUeA@mail.gmail.com>
Subject: Re: [PATCH v12 3/3] Bluetooth: start and stop service discovery
From: Jakub Pawlowski <jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Nov 28, 2014 at 5:27 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Jakub,
>
> On Thu, Nov 27, 2014, Jakub Pawlowski wrote:
>> This patch introduces start service discovery method. The reason
>> behind that is to enable users to find specific services in range
>> by UUID. Whole filtering is done in mgmt_device_found.
>>
>> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
>> ---
>>  include/net/bluetooth/hci_core.h |   4 +
>>  include/net/bluetooth/mgmt.h     |   9 ++
>>  net/bluetooth/hci_core.c         |   5 +
>>  net/bluetooth/mgmt.c             | 271 ++++++++++++++++++++++++++++++++++-----
>>  4 files changed, 260 insertions(+), 29 deletions(-)
>
> With the exception of "stop service discovery" in the subject of this
> patch that doesn't exist anymore, the patches are starting to look quite
> good to me. Thank you for your patience with the many review rounds so
> far!
I fixed all commit names according to your guides.
It's me that should be thankful you for your patience!

> Btw, for consistency please try to formulate your commit message
> subjects so that they start with a verb, e.g. "Add ...", "Implement
> ...", "Fix ..." etc.
>
> I've asked Marcel to take one last review of your patches before we push
> them upstream.
>
> Johan
