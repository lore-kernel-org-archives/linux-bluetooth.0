Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <292E4AE7-0A38-42D5-82C1-D50C6D64DEDE@holtmann.org>
References: <1367346580-6647-1-git-send-email-andre.guedes@openbossa.org>
	<292E4AE7-0A38-42D5-82C1-D50C6D64DEDE@holtmann.org>
Date: Thu, 2 May 2013 10:16:07 -0300
Message-ID: <CACJA=fVhhM91qLqFZGUGHy6zQ6qwz+LCkcyYu0vVf9qq9Q9A3w@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Update Discovery to use HCI request framework
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, May 1, 2013 at 10:59 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Andre,
>
>> This v3 is very similar to the previous patch set, except it has some minor
>> changes Johan suggested.
>>
>> This patch set requires the patch "Bluetooth: Fix checks for LE support on
>> LE-only controllers" in order to apply (this patch is already acked).
>
> do we have test cases in mgmt-tester that covers all the different command variations? Especially also when it comes to name resolving and interleaved discovery.

Currently we have tests covering invalid parameters and LE-only and
interleaved discovery success flow. Bruna and Jefferson are working on
more test cases to cover error flows.

BR,

Andre
