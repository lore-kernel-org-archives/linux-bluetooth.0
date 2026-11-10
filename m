Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.142.180.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306112;
	b=tZeMEfkaH1LUIYXX4VPy/shfRIhR9hXWk+6qPaECSm6N6wvE81A5QmJrjuJEmB04DgKH
	 //ojqjglgxJYQdRLxEuIUmzSwNIlL0WL41ZZ7gWRLAdLBQGPONLnzez1+fXNy4FP6WJYA
	 TVCTue8NVvMR2ODedBLd7iELzUnRIAhu5Q3Cy8T53D8oKoNf6YvPK2hYjk0SdXXaJHSus
	 egod9pgvpN/MwyFhBE8xx1R3vgFLM8ruDGJHry6l/s84Mb9A+XVQ7VC/o+H9QusViVV7k
	 xByx4YCS1a4Vz2qnU9nkJMXbflxBhRfXlQtDa8K3LLlGhl8CkCmkzWWGUObEIu4JVBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306112;
	h=DMARC-Filter:Received:Date:From:To:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4RjiHFSGtFGI5JfcAYv07qfSKq6xK83qO3wQQHxqTEI=;
	b=im0YogZ5EPTBucKBCDfWnMRrKQb0F8zH2TauCaVUXsHbaF3VtazKY4po5g7ztZRWSaM3
	 D536pgt0V17RGzlIcOcKGTlWWhJvyIujiKO6z7MFvdkaHeyxljmkY2uJ3bgpd6ivWVews
	 xw/+Fq3bggN18CpS4kB/9ZkNhOgItbeYX56fFgcjm9RfEQzgXhRz6+/PmV0yWXkAPlaKW
	 RJLDX8wBo0navA2/2BoMtq9rHkknLW8fhV3Yn9wvNyT3wm9JlT/8qaWp7ZUZjBouWQ2Fy
	 Vd38rMBcYPNfiSxfDU3J15fT18fpxqIlHXqwyliZidytVBUyPqkRqA661DwZZaJ73pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=makrotopia.org;
	spf=pass smtp.mailfrom=makrotopia.org;
	arc=none smtp.remote-ip=185.142.180.65
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E33606DE29;
	Tue, 10 Nov 2026 10:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55E33606DE29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xQimM-000000006so-27Tz;
	Tue, 10 Nov 2026 10:21:42 +0000
Date: Tue, 10 Nov 2026 10:21:35 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Hans de Goede <hansg@kernel.org>, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 0/4] device_schedule_reprobe(): core helper and
 conversions
Message-ID: <avLv6TwefQu-GPWp@makrotopia.org>
References: <cover.1792203271.git.daniel@makrotopia.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1792203271.git.daniel@makrotopia.org>

Hi Greg,

On Sat, Oct 17, 2026 at 09:55:17AM +0100, Daniel Golle wrote:
> iwlwifi and hci_h5 re-probe their own device from a work item in module
> text ending in module_put(THIS_MODULE), which a concurrent rmmod can
> race, and nothing ties the re-probe to the binding that asked for it.
> btintel_pcie re-probes synchronously from its own reset work. This
> series adds device_schedule_reprobe() to the driver core and converts
> all three.
> 
> Tested on an Intel AX101 with patches 1 to 3, PROVE_LOCKING and
> DEBUG_OBJECTS_WORK: a re-probe, and an unbind, rmmod, PCI removal,
> suspend and reboot with one pending. The unbind and the removals
> cancelled it, and it ran after resume. The stock iwlwifi code undid
> the unbind, and rmmod with its work held just past module_put() oopsed
> in lockdep. Patches 3 and 4 are untested for lack of hardware.

Now that the most hardcore merge-window ever is over and v7.4-rc1 is
out, can you take a look at this?

The series has received positive feedback and was tested by some more
of the bluetooth folks by now, and is immediately useful to address
currently buggy behavior of existing popular driver, and prevent the
same wrong pattern from being duplicated into new drivers.


Cheers


Daniel
