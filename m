Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904EB2D543E
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 23:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765582893; cv=none; b=SEDDtnTb36UANw0cu9oL61flY/PltIcHFYoTLZjHhZ+zy/aFpc7xARh0/yRDY56NO3KS6YXQeJPry+T5LEcqg2X/bYZg6BYDVVK3Aqy7w8HQMIdu329NmudvmZg/k3H2yCgp+Z+/1IHlVpNAtftdx7RQxIImf7GMKi9zUbHytOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765582893; c=relaxed/simple;
	bh=Q31UIahqkWIDEy+Fnrozta4NR5ehsmlDnX3agKM3Rm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q95eqiC4qbJuwWlcy6tlJD56pQUbf3TjMuuAh1Ts2kITQGACDES1uH5+CVmfwGqu/FAfMuULfGlytinAmuygejNkRzud8iWiH9Dzo/2ntv+lztAyy9OIM7lG8+sbmCSwxuji51RCJm3gPDT0dPTJfKvOQkAoHclLxOc9aXs4oKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=hGh11h02; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hGh11h02"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8s2qcLEsKfTODTLqUJwnV9s/vstVlhsICNUu+63k/ro=; b=hGh11h02tjP7yVwYXUgc85B2Hm
	4i1RoD92HatspMaVdBNQlHFZv3iR9AUWQiHwCal5NBdDlpqlRYmCAl4vkfDCgt+27bhLcJSD74em7
	dqWnEhAIg9dp9bGwxx6MfxGqKVJfsYRsERUsfpw53gLrjHEyZ1ICyBlTWi+j9UTfC7xcesjJ9GqKS
	Yadaw1wWyfh3BrRsTu+cespobR6DrGVkejO6DtwGb6bKyWYQFLdOpSzLN8IB7CrTnNBgBQHib1fxu
	eXLgUApimFyik0NG5XWXFtSgXOnrtX7iKSDw0CGpPpEYsKN4IIR7w5rtrX94QfVyscAlC7fWPrRDJ
	vXal62Hw==;
Received: from 241.red-83-35-220.dynamicip.rima-tde.net ([83.35.220.241] helo=[192.168.1.65])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vUClK-00CCdP-HR; Sat, 13 Dec 2025 00:41:26 +0100
Message-ID: <9b4aa97c-8796-48f0-a6d4-abee8ea7888b@igalia.com>
Date: Sat, 13 Dec 2025 00:41:26 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v2 1/1] Support for config fragments (conf.d style
 dirs)
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20251212202240.4057163-1-mafm@igalia.com>
 <20251212202240.4057163-2-mafm@igalia.com>
 <CABBYNZ+NDSvSHO9Q9jfavE0e+895-oNFs-5Y6P0=h2XX_+oq=w@mail.gmail.com>
Content-Language: en-US, en-GB
From: "Manuel A. Fernandez Montecelo" <mafm@igalia.com>
In-Reply-To: <CABBYNZ+NDSvSHO9Q9jfavE0e+895-oNFs-5Y6P0=h2XX_+oq=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 12/12/2025 22:07, Luiz Augusto von Dentz wrote:
>> + * The final, effective values are:
>> + *
>> + *   DiscoverableTimeout=30
> 
> And PairableTimeout=15, right?

Yes, good catch, thanks.  I suppose that it got lost at some point when 
I was reformatting the paragraphs.


>> @@ -284,6 +285,8 @@ static GKeyFile *load_config(const char *name)
>>                  return NULL;
>>          }
>>
>> +       confd_process_config(keyfile, main_conf_file_path, FALSE, TRUE);
> 
> After a second look this does seem to completely ignore the formatting
> of logging when parsing main.conf,

I don't understand this sentence.  Do you mean that it doesn't emit log 
errors when the extra config files cannot be parsed, like in src/main.c:279?

There's a check at the beginning of confd_override_config(), it emits a 
warning (not an error) if it fails to load the file.

Or do you mean the different, finer-grained checks and logging messages 
when parsing keys and values?


> also I do wonder why you didn't
> just reuse load_config to parse the files in conf.d, we will need to
> adjust the use of main_conf_file_path perhaps to just conf_file_path,
> or better yet add a second argument for the path represented by the
> GKeyFile, but I believe this is a lot more straightforward overwriting
> the same GKeyFile with all the values from conf.d,

(As means of explaining why I did it that way, not as a reason to change 
it -- I'm fine with doing it in other ways)

I was trying different approaches, I think that I started doing what you 
say when looking at src/main.c.

But then I thought better to implement it in a self-contained way, so 
the changes to the existing code were minimal, and it could be reused in 
different places (profile/input/manager.c, etc), without having to 
replicate the walking over the extra files.

Also, with the config merged into a single GKeyFile in-place, it will 
avoid problems like for example if the parsing_*() functions assume that 
there's only one config file, and in each pass (loading each config 
file) setting default values if they don't find in the current file 
being parsed, even if it was set in a previous pass.  All such places 
parsing config would have to be mindful that there could be multiple 
files, each containing partial config, and so the higher-level code has 
to do the job of merging the partial config.  (Not sure if it makes sense?)

And perhaps a minor nuisance, special cases like use of 
getenv("CONFIGURATION_DIRECTORY") will have to be taken into account in 
more places.

So, all in all, I thought that for the existing code and future changes, 
it would be simpler if the GKeyFile returned from load_config() (or 
equivalent in other sections of code) contained the base+extended 
configuration all in one GKeyFile, with the extended config injected in 
that same place of the base file, so it would work transparently for the 
rest of the code parsing it.


> actually I don't
> think this really checks the existing groups and keys because it will
> initially be based on the existing main.conf which can be wrong
> already, but you will only be able to detect that while in
> parse_config.

Yes, the new code assumes that the base config file is correct, and it 
would paper over errors.

For example, if the base file (e.g. main.conf) contains a wrong group 
not known to the existing bluetooth code, and the extra config contain 
keys in that group, it will load the new key values into GKeyFile.  My 
understanding (I didn't check thoroughly) is that the rest of the 
bluetooh code will ignore these, as it will try to parse only groups and 
keys that it knows about -- it's hardcoded.

Also, in the current implementation, it will mask some problems that 
could be present in the config files.  For example if main.conf contains 
"PairableTimeout = garbage" instead of an integer, and 
main.conf.d/10-override-pairabletimeout.conf contains "PairableTimeout = 
garbageagain", and another 
main.conf.d/99-override-pairabletimeout-final.conf "PairableTimeout = 
0", it will not emit errors for neither main.conf nor 
main.conf.d/10-override-pairabletimeout.conf -- it will only see the 
last "PairableTimeout = 0".

So, yes, this is a disadvantage of this approach... it will paper over 
problems instead of pinpointing the problem in the individual files.


> So except if I miss something above, I think we should really parse
> each config separately, and not just load and overwrite.

After the explanations above, I guess that you still prefer to load and 
parse each file individually, to detect problems in the individual files?
If so, I'll work on it on the next version.


PS: I will be off for some days so please excuse delays in replying.


Cheers.
-- 
Manuel A. Fernandez Montecelo <mafm@igalia.com>
