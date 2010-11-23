Return-Path: <cyrus@holtmann.org>
Message-ID: <4CEB9296.2060702@Atheros.com>
Date: Tue, 23 Nov 2010 15:38:22 +0530
From: Suraj Sumangala <suraj@Atheros.com>
MIME-Version: 1.0
To: <linux-bluetooth@vger.kernel.org>,
	<Jothikumar.Mothilal@Atheros.com>
Subject: Re: [PATCH] hciattach: download configuration at maximum baud rate
 possible
References: <1290423480-29840-1-git-send-email-suraj@atheros.com> <20101123092346.GB28017@jh-x301>
In-Reply-To: <20101123092346.GB28017@jh-x301>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 11/23/2010 2:53 PM, Johan Hedberg wrote:
> In general the patch looks ok'ish, but:
>
>> >  +	if (set_speed(fd, ti, speed)<  0) {
>> >  +		perror("Can't set required baud rate");
>> >  +		return -1;
>> >  +	}
> To be consistent with the other return values, instead of -1 you should
> be returning a proper errno here. I.e. probably something like:
>
> 	if (set_speed(fd, ti, speed)<  0) {
> 		err = -errno;
> 		perror("Can't set required baud rate");
> 		return err;

The set_speed function is defined in hciattach.c as

int set_speed(...)
{
	cfsetospeed(...);
	cfsetispeed(...);
	return tcsetattr(...);
}

I think this function could end up returning Success even if the first 
two function calls failed?

Does it makes sense to rewrite it to

int set_speed(...)
{
	if(cfsetospeed(...) < 0)
		return -errno;
	if(cfsetispeed(...) < 0)
		return -errno;
	return tcsetattr(...);
}

Then, I can return the error code directly in my function call.

Regards
Suraj
	
