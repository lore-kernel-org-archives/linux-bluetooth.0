Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967722F7F15
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 10:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789814623; cv=none; b=YO0eDyP4HgOsxHSHKT5/GU8T1NpOodsg8cA3kDQF5dW4t2SNWjCGhdtYi4VOX2H+/bK1ACY0SGSYCMFbzgEI8w4T2ilFAWGOitXNyhbE7+Dbes/Jx+pGEMAWF16Gnud/oCJRW8h+d4WSBM/qLx1UYHLeoyB6kw/TD93iIFr4p80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789814623; c=relaxed/simple;
	bh=Kb6GJ+6exjuqmNy32cYks6dmD87Wc90upHw+/ODzcdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gebYO756MTvhAaUArzKJsRKsl1c5Ue6/3TxvdE7Bav2zA3xhXeI7aOCp3lbTpMGt/TgsfjstEuYwjjzChZ4NIOD/V8wxxGvpGwy+arW+oe1MyeUAjKJTlCCq+LGf2prbNJE+Ei94PWUuUYegzhuScgzYonioIy+Y7+Yq2lCwmis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIwz1I9J; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIwz1I9J"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so8171215e9.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 03:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789814619; x=1790419419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jAiOs4ftLN5jbwUNxbjAHqs++vwR8RTHCuoDXv12AGw=;
        b=LIwz1I9J68G6bZdBxuXkOVgtqTg/4K6F5kv9AYpwP9UWHDKGl8jtxJDHk/oT9FSx8D
         ch9zeEm00Wmzfl9AqqMJ3Nw4wmP3rei4vGlFkieumC57zp1zUD4IlDkS00hTGB5q5Oql
         sJcKQEnHo/08l5bsS7pL0yWy6NTuOCXk0s3fwVT8CzTq9yBrcMSqoqEXPmtfXvx4UlJg
         kWOaY20IWgoURKdAxlxK+pQ06/XfjxWi1GlHPwr9wwiTbBxmF/CPDzEwNTlFTS2Yy11B
         zjWPTxuunhwNKUzHJZigsZKhxgtcT8m+jTccyQZwZYdYj5ZLwkurply0ojvLVOZKAl8l
         tHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789814619; x=1790419419;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jAiOs4ftLN5jbwUNxbjAHqs++vwR8RTHCuoDXv12AGw=;
        b=Ui9pf6YfbpX4z5aYNOlYZVzzoVd055IyrJ1OUlUQ00V+vj0HAkdWtT4CkXVFdB7HlF
         5IeqKJ47XNUNdBYDrv4n+UXuT0xRbbr4LyHnHwsGlslC+gB4c9qmblRf9pk9Mg4cAOIu
         Cw7qQz8sRGNqqXy+fWnch7Zv2CjgPgsbx68KL8EoGnEgOHlGF993R0YXPD5xLhlyN9YS
         gI6kqjSxevErNZ46I9OSWvSGLi3ELvrD18h8cLttSSwA6HGviptS+pPodU3+vL4HjyZK
         qGuUR/676q+mgnRHigfG5/CngKv/ahv3kMFAdfUGWsgT/60c+uonbxJZjdL09UOkhRen
         NV8A==
X-Gm-Message-State: AFuF++nGSUB5n+Q+3RrnsBDTcQdF503curOyzhX3DcP5I7yyGQbYm91Z
	qKLASeKuuLHQVjPZKul8/as6vDorb+9xqPqkUtWzKWl4+X9GrXAGkcVjS3foAkSJ1G3PCg==
X-Gm-Gg: AYBFou261wAqd4s4h+9den2DIK9Z8ScJTo194hDBpUmyVjNiXQt8folUZZ0kNnbKKHp
	AeGDbL+Mmoxo6pJKQt4+sKy1uXaEAdAOSTXZkNaY2ZD6J4gxJ1jbrAO2bPx7le7qVkal0q7d8OA
	ah/Mr1GfHWRHABm7jSOxj8sSz4uaKeLxBY/IMnRDmD5A5P55EymeOXckEfg5dsd7gY15yKNnRYJ
	TUUOFEk3fQZAFl/5D43z7Ci+D/IFLs4QK2nryFncjl07a5YV1SoNIZ03F0fEufRdbTAjfj7Lip6
	UmIYXkn87rP+PbtUu/z9iaYabsaaItFH+F/tWH+HXqai9PmVjtFrh0YPldztbgIhISfDWTeZWj8
	JDrtvXq/Kq8+qcSgVWYhK7gQn4y1iaLIeXKZViUKJfah1m8yQAeE56g90oLssdFd7wt7hCsrWfh
	asQCcMSAsVackrGikWmc2yHtdry/CxX5s0Q54i2LwL4ZChcPMAdE7ZH6BKGJ8rM7/VtAA=
X-Received: by 2002:a05:600c:8b24:b0:49f:ce78:3563 with SMTP id 5b1f17b1804b1-49fce78360emr15128345e9.20.1789814618806;
        Sat, 19 Sep 2026 03:43:38 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc6ca43edsm128396395e9.0.2026.09.19.03.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 03:43:37 -0700 (PDT)
Date: Sat, 19 Sep 2026 13:43:34 +0300
From: Dan Carpenter <error27@gmail.com>
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [bug report] Bluetooth: btusb: Add support for Qualcomm
 multi-subsystem QCC2072
Message-ID: <aq5nVkN4TvIJNh4y@stanley.mountain>
References: <aqw8ShHyjdZhPc4U@stanley.mountain>
 <aqw8zNc6tXeaNPNV@stanley.mountain>
 <74e197ab-7bb7-46c8-9485-70ba64b4b552@oss.qualcomm.com>
 <aq4YdQS3RhUEIm9z@stanley.mountain>
 <988c4737-16a8-4c79-b3d6-e96de8dd174d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <988c4737-16a8-4c79-b3d6-e96de8dd174d@oss.qualcomm.com>

On Sat, Sep 19, 2026 at 03:04:06PM +0800, Zijun Hu wrote:
> On 9/19/2026 1:07 PM, Dan Carpenter wrote:
> > Zero, sure.
> > 
> >    268  
> >    269          if (IS_ERR(skb)) {
> >    270                  if (!event)
> >    271                          bt_dev_err(hdev, "Opcode 0x%4.4x failed: %ld", opcode,
> >    272                                     PTR_ERR(skb));
> >    273                  return PTR_ERR(skb);
> >                         ^^^^^^^^^^^^^^^^^^^
> > Error pointer.  Fine.
> > 
> >    274          }
> >    275  
> >    276          status = skb->data[0];
> >    277  
> >    278          kfree_skb(skb);
> >    279  
> >    280          return status;
> >                 ^^^^^^^^^^^^^
> > But this seems like it could be a positive...
> > 
> 
> For HCI_OP_RESET, execution cannot reach this point when status != 0.
> 
> >    281  }

Actually even for the other opcodes it looks like doing:

	status = skb->data[0];
	return status;

is just a more complicated way to write "return 0;".  :/

regards,
dan carpenter
