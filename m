Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] tools/seq2bseq : Fix the same expression issue in if condition
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140912165730.GC3671@t440s>
Date: Fri, 12 Sep 2014 10:05:12 -0700
Cc: gowtham babu <gowtham.ab@samsung.com>,
	linux-bluetooth@vger.kernel.org, d.kasatkin@samsung.com,
	bharat.panda@samsung.com, cpgs@samsung.com
Message-Id: <705AF308-550F-47C4-ADD3-9276158CA280@holtmann.org>
References: <1410331363-3548-1-git-send-email-gowtham.ab@samsung.com> <20140912165730.GC3671@t440s>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> Below are the list of similar patches under 'tools' which are not yet reviewed
>> 
>> 1) tools/csr_usb : Fix Resource leak: file
>> 2) tools/hciattach : Fix syntax error
>> 3) tools/btsnoop : Fix variable reassigning issue
> 
> This kind of stuff does not belong in a commit message.
> 
>> diff --git a/tools/seq2bseq.c b/tools/seq2bseq.c
>> index 7657a57..521d20e 100644
>> --- a/tools/seq2bseq.c
>> +++ b/tools/seq2bseq.c
>> @@ -40,7 +40,7 @@ static int convert_line(int fd, const char *line)
>> 	char str[3];
>> 	unsigned char val;
>> 
>> -	if (line[0] == '*' || line[0] == '\r' || line[0] == '\r')
>> +	if (line[0] == '*' || line[0] == '\r')
>> 		return 0;
>> 
>> 	while (1) {
> 
> Are you sure the code wasn't intending to check for '\n'?

yes, it was intended to check for \r and \n. This is my mistake here.

Regards

Marcel

