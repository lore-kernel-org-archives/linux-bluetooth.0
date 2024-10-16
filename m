Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A2320C03B
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089733; cv=none; b=m9LYlNXpCU9qWLZMYKb6sw50/U7ODylC4A4K15B6d7B8nNHH2/KPXkZKgusiusiYAX3j1vZUTj/XeqC85tKw93PxqX+y8UTaBd2UK1bxBSceA8gE75YuNWA3+veCvgio6hBwpsxTn/dupI6rp51YFWk5Efg6J15LoBNBGh3iKM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089733; c=relaxed/simple;
	bh=ZpYrtK7MtUBEI/ZYVcQlR8ZVdajfCjo8jOMxyFfCLu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIke/IcCsJ/mPXmwE6xGUv8O+r65EL0Mhce13F2F6nUfWcA98Bhef6IfLR0OLuDpSweKJDok+bVzQdp0Ok01CbH+l81qlECPaM4uaFLR9xepnwzNsTUcO3uJ0/6ecy7zAz0tITBxHJ4lSSu4SXza3Akysht/ZiPKnybyb7tFoTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pZV+0iG1; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pZV+0iG1"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c99be0a4bbso917128a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 07:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729089730; x=1729694530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C/Xs71I9jBNZyAZ00FOHiyLsgfN1x+hSe7LFDe6cUfY=;
        b=pZV+0iG1JSzajbptQfeHKBAeTHGJ3Z0dZEgREh1Q7XIIiILAObn0H8ORUHl8by6EyM
         3OpJXPsAm3urWgw1Ww7t4nONnJrXXFLkf5DTolyS9QpqekimqxGA75KUmcFF8M85U7d4
         +RnJcnhMypxxyZVN0YWurcGs18YoVhm9PIbL61gYDcNHy+l8s5va/gb6Qj2d1A6XxQuc
         PzPqUemeVWVUUvQYLPjX9JmCfVBqRvBCP6AZLEfl5Se9rKx03yL7Lba2Z1Ekk5J+si+U
         Du+QyxO+zeJ5/IJ6AdYHH5HKvmKvv8210/XTXog7WwhLtXeupxBZZ5yzRwvUyFA0IGsO
         vEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729089730; x=1729694530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/Xs71I9jBNZyAZ00FOHiyLsgfN1x+hSe7LFDe6cUfY=;
        b=tRsPEtlozHfyJmoqOPHjyjXO5OMB5B1lFV6R8nXYcbW6SPEuoAZ1DX/XydD+K0klDJ
         KuRUlTB1TY8CDgjfA9I3XXxv5Hx/EVFzln473a2KoDWli7KqDXjVplMAdzUb412vonYS
         TiV/dztaiB3o/QScmez1Pux9yog9fDVHo7CbuIs0iIjZpdjqL98g5Bs8mL8CgdurquDR
         0PuWUmoAH39l9bS7jaENen9kcMbWb+ezzYpvWp+tOdtKxkxccxjC9hgY0jWkHPG6leQQ
         LhV0js9Wxgc8dLu2OT3uYdbawtQUsQ7YbNkFoirnvHQU9d7MccIwhcPzw4QTpKwjMBvs
         UbAw==
X-Forwarded-Encrypted: i=1; AJvYcCUF6tsmwWatJTRCsdLi4qUHL8Sooty5Tx8RQdFDaUBtBjDnPXUa8VKBlYaad1f0foE6rXLrpTFcBIX6rVhP0G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO3DVXGhPQs10BfyFVx4HuzD+DWmmwzmkZWtYjugDoFJRBLfDP
	romW0G/GakFt+MM3QxBpoRHqTZqDfjegMs+zx7i9BcZGDXR2zX2tlzXrliTzACQ=
X-Google-Smtp-Source: AGHT+IGWcI4tfnDXcGH4X5+Vm2QybBCvnU53W1Fc4QZtYSFr0ttLHY/etEUDYKHSJtlqb6b6Fb7RtQ==
X-Received: by 2002:a05:6402:2695:b0:5c9:709c:247f with SMTP id 4fb4d7f45d1cf-5c9709c9a2emr10927291a12.2.1729089730331;
        Wed, 16 Oct 2024 07:42:10 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d5042f7sm1823649a12.42.2024.10.16.07.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 07:42:09 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:42:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, skhan@linuxfoundation.org,
	kernel-janitors@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4][next] Bluetooth: btintel_pcie: Remove structrually
 deadcode
Message-ID: <e22aebb2-0961-459c-bc02-3165c364115b@stanley.mountain>
References: <20241015232212.19242-1-everestkc@everestkc.com.np>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015232212.19242-1-everestkc@everestkc.com.np>

On Tue, Oct 15, 2024 at 05:22:05PM -0600, Everest K.C. wrote:
> The switch case statement has a default branch. Thus, the return
> statement at the end of the function can never be reached.
> Fix it by removing the return statement at the end of the
> function.
> 
> This issue was reported by Coverity Scan.
> 
> Fixes: 5ea625845b0f ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> V3 -> V4: - Fixed typo in the subject

I don't like to be the typo police but, no, you didn't fix the typo.  :P

regards,
dan carpenter

